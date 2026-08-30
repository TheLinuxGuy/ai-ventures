TASK: Build a weekly "security digest" email for this Linux server — a mobile-first
HTML message with a colour-coded KPI tile grid at the top and detail sections below,
including geo/ISP enrichment of attacker IPs, sent on a cron schedule. You are
starting with no context about this box; assess it first.

=== OBJECTIVE ===
A Python 3 script + a cron entry that emails, once a week, a summary of the
server's security-relevant activity over the last 7 days to a recipient address I
give you (ask; if I don't answer use a clearly-marked placeholder and tell me where
to change it). The email must render well on an iPhone in BOTH light and dark mode:
a grid of KPI tiles first, then scrollable detail sections, with IP addresses
annotated with country / city / ISP.

=== STEP 1: ASSESS WHAT THIS HOST CAN REPORT ===
Read-only survey. Decide which data sources exist and note formats. Check for:
- Auth logs: /var/log/auth.log, /var/log/secure, or journald only. DO NOT hardcode
  paths — detect. Note the timestamp format: ISO-8601 ("2026-08-29T20:10:23-07:00"),
  traditional year-less syslog ("Aug 29 20:10:23"), or journald short-iso. A log
  file may even contain MIXED offsets if the box changed timezone — handle it.
- SSH: successful logins (Accepted password/publickey; capture the auth method and,
  if present, the key fingerprint), failed/invalid attempts, distinct source IPs.
  Is there an allowlist to compare against (fail2ban ignoreip, CSF csf.allow +
  csf.ignore, a config file)? If so, compute "successful SSH logins from
  NON-allowlisted IPs" as a KPI and list them.
- Firewall / IPS: fail2ban (fail2ban-client status + per-jail banned counts,
  /var/log/fail2ban.log), CSF/LFD (/var/log/lfd.log, /etc/csf/csf.deny), ufw log,
  nft/iptables counters. Count bans in the window, group by jail/trigger, list top
  source IPs and top targeted users/services.
- sudo / su usage, new sessions (last, lastb / btmp).
- Pending package updates + how many are security-flagged (apt: apt-get -s upgrade;
  dnf: dnf updateinfo list sec; zypper). Last auto-update run (unattended-upgrades /
  dnf-automatic). "reboot-required" flag; running vs newest installed kernel.
- systemd failed units.
- Disk usage per filesystem + inodes; mdadm/RAID health; smartctl -H if present.
- Load avg, memory/swap pressure, OOM-kill events (journalctl -k | grep -i oom).
- Time sync (timedatectl / chrony / ntp offset).
- TLS cert expiry for any certs you can locate (certbot certificates, common paths)
  — soonest expiry is a good KPI.
- Malware/rootkit tooling IF installed: rkhunter (last run + warning count), ClamAV
  (signature freshness, scan hits), maldet, AIDE, debsums/rpm -Va anomalies.
- MTA if present: messages rejected as spam/virus, queue size, SMTP-AUTH failures.
  ModSecurity audit log if present (host + top rule IDs).
- Web server logs if present: 5xx count, top attacked paths.
Anything unavailable -> the digest renders that section as "not available on this
host". Never let a missing tool/log crash the script.
Give me a short list of what you found monitorable and what you're skipping and why.

=== STEP 2: BUILD A SHARED GEO/ISP HELPER ===
Create /usr/local/sbin/ipgeo.py (chmod 755, importable + CLI). Two data sources:
- COUNTRY / country-code: use a LOCAL offline database — geoiplookup / geoiplookup6
  (legacy MaxMind, often already present), or mmdblookup with a GeoLite2 db, or a
  pure-python reader. Offline = unlimited; use it for every IP and all aggregates.
  If no local country DB exists, install one (geoip-database or geoipupdate/GeoLite2)
  or note that country data is unavailable.
- CITY + ISP/org: https://ipwho.is/<ip>  (JSON, no auth). It is rate-limited to
  ~1000 requests/day PER SOURCE PUBLIC IP (i.e. this server's egress IP), so:
    * cache every result in /var/cache/ipgeo/cache.json with a 30-day TTL
      (geo data barely changes); atomic write (tmp + os.replace).
    * enforce a hard daily budget (e.g. 900) tracked as {date,count} in the cache;
      once hit, stop calling and fall back to country-only for the rest of the day.
    * 3 s timeout per call, small sleep between live calls, set a User-Agent.
    * ONLY look up IPs you will actually display (the top ~10–15 per section, plus
      any immediate-alert IP) — never the hundreds of IPs behind an aggregate.
    * skip private/reserved IPs; never raise — return partial/empty on any error.
- API: lookup(ip, allow_api=True) -> dict(cc,country,region,city,isp,asn,source)
  CLI: `ipgeo.py <ip>` prints a one-liner "City, Region, CC · ISP" for shell use.
Test it: look up ~5 mixed IPs (v4, v6, a known VPS-abuse IP, a private IP); confirm
the second call is served from cache; print the cache + budget state.

=== STEP 3: BUILD THE DIGEST SCRIPT ===
One Python 3 file at /usr/local/sbin/weekly-security-digest.py (chmod 750,
root:root, no secrets). Requirements:
- Every data source wrapped in try/except; degrade gracefully.
- Log reader helper that also reads .1 and .*.gz rotations. If only journald exists,
  use `journalctl --since "-7 days" -o short-iso`.
- Timestamp parsing accepting ISO-8601, year-less syslog (assume current year; if the
  parsed date is >1 day in the future, subtract a year), and journald short-iso;
  timezone-aware datetimes; filter everything to a 7-day window.
- Cap reads on very large logs (e.g. last ~50 MB) so the run stays < ~30 s.
- GEO ENRICHMENT (import ipgeo from Step 2):
    * memoised offline country_of(ip) for aggregates.
    * an "Attack origins (by volume)" section AND a KPI tile "Top attack origin"
      (top country + its % of total attack volume). Aggregate hit counts and
      distinct-IP counts per country across every attacker IP set you collected
      (SSH failures + firewall bans + MTA auth failures …) using the OFFLINE db.
    * append the country code to each top-IP row (offline); add city + ISP to the
      displayed top IPs and to any non-allowlisted SSH login rows (cached API).
- KPI model: each KPI has label, value, status in {ok,warn,bad,neutral}, short
  sub-label. Pick 8–12 most decision-relevant for THIS host. Example thresholds:
  pending security updates >0 = bad; rkhunter warnings >0 = bad; any malware hit
  = bad; disk >=90% = bad, >=80% = warn; non-allowlisted SSH login >0 = bad;
  cert expiring <14d = bad, <30d = warn; "top attack origin" = neutral.
- Emit BOTH a plain-text body and an HTML body as multipart/alternative (plain
  first). The plain body should still carry the country codes and the origins table.
- CLI: default / "--send" builds and sends; "--dry-run" prints the plain body and
  writes the HTML to a temp file, no send.

HTML design — must be correct in BOTH light and dark mode on iOS Mail:
- <!doctype html>; <meta name="viewport" width=device-width>;
  <meta name="color-scheme" content="light dark">;
  <meta name="supported-color-schemes" content="light dark">;
  and `:root { color-scheme: light dark; }` in the <style>.
- LIGHT mode = inline styles on every element (so clients that strip <style> still
  get a readable light email). DARK mode = a single
  `@media (prefers-color-scheme: dark) { … }` block in <head> <style> that overrides
  via CLASS selectors with !important. 
- DO NOT use a blanket `div,span,td { color:#fff !important }` dark rule — it will
  whitewash text that sits on still-light tile backgrounds and destroy your status
  colours. Give every themable element a class (headings, sub-text, muted labels,
  table cells, callout boxes, and each KPI tile) and override each class explicitly.
- KPI tiles: a 2-column <table> (email-safe, not CSS grid). Each tile is a
  <div class="kpi kpi-<status>"> containing
  <div class="kpi-val">, <div class="kpi-lbl">, <div class="kpi-sub">.
  Light: pale tinted background + saturated dark number + near-black label
    ok      #0a7c2f on #e7f6ec ; warn #8a6100 on #fdf4e3 ;
    bad     #b3261e on #fbeae9 ; neutral #1f4e79 on #e8f0f8 ; 4px left border in the
    number colour.
  Dark (@media, by class): DARK tinted background + BRIGHT number + light-grey label
    .kpi-ok      { background:#0f2418; border-color:#2f7d4f } .kpi-ok .kpi-val{color:#45d581}
    .kpi-warn    { background:#2b2209; border-color:#8a6a1f } .kpi-warn .kpi-val{color:#f6b73f}
    .kpi-bad     { background:#2d1512; border-color:#a33b34 } .kpi-bad .kpi-val{color:#f87066}
    .kpi-neutral { background:#0f2236; border-color:#3a6ea5 } .kpi-neutral .kpi-val{color:#7ab2e9}
    .kpi-lbl { color:#d0d0d6 } .kpi-sub { color:#9b9ba1 }
  (Adjust hues to taste, but keep number-vs-background contrast >= ~4.5:1 in BOTH modes.)
- Also dark-override: body/background -> #000, the card -> ~#141416, headings ->
  ~#f4f4f7, section-header bottom border -> ~#3a3a3c, body text -> ~#e7e7ec, muted
  text -> ~#9b9ba1, any coloured callout box -> dark equivalent.
- Layout: outer full-width table on a neutral bg; a centered card max-width 600px,
  border-radius 14, padding 20. H1 "Weekly Security Digest"; subtitle = FQDN ·
  "Mon D, YYYY HH:MM TZ" · "last 7 days". Section headers = <h2 class="d-h2"> with a
  2px bottom border. Detail rows = small <table>: left label, right value
  (right-aligned, monospace). System font stack; no external images or web fonts.
- Subject: "[<shorthostname> weekly] Security digest — YYYY-MM-DD".

=== STEP 4: EMAIL DELIVERY & DELIVERABILITY ===
- Pick a working send path: if an MTA listens on 127.0.0.1:25, send via smtplib to
  it; else /usr/sbin/sendmail -t; else, if I give SMTP creds, configure msmtp; else
  install a minimal mailer and tell me.
- MIME HYGIENE — get these right or the message gets junked (a local rspamd / spam
  filter will score and file it):
    * Set a real, deliverable From (an existing local mailbox, e.g. the recipient
      itself, or root@<fqdn> if that delivers). A made-up address like
      security@<subdomain> scores badly. Set envelope-from to the same address.
    * Add a Message-ID header (email.utils.make_msgid(domain=fqdn)) — missing MID is
      a large spam-score hit.
    * Encode the text parts as quoted-printable, NOT base64 (Python's MIMEText with
      a utf-8 charset defaults to base64, which triggers "bogus base64 text" rules).
      Use email.charset.Charset("utf-8") with body_encoding = QP.
    * Add Date and "Auto-Submitted: auto-generated" headers, and an X-Mailer.
    * Minimise invisible/empty HTML elements (hidden preheader spans, zero-height
      spacer divs) — spam filters count them. Use margins/padding for spacing.
- Send a real test. Verify from the MTA log that it was ACCEPTED and DELIVERED, and
  determine the destination FOLDER (inbox vs Junk/Spam) — check the local delivery
  log / Maildir path, or the spam filter's score log if there is one. If it landed
  in spam, read the filter's symbol breakdown, fix the offending headers/content,
  and resend until it reaches the inbox. If you truly cannot determine the folder,
  say so and ask me to check.

=== STEP 5: SCHEDULE ===
/etc/cron.d/weekly-security-digest with explicit SHELL=/bin/bash and a PATH line,
running the script as root once a week (e.g. "30 7 * * 1"). Confirm it parses and
the schedule matches what I asked for.

=== STEP 6: (OPTIONAL) NON-ALLOWLISTED SSH LOGIN ALERT ===
Only if this host has an IP allowlist source. Add a pam_exec hook on the sshd PAM
stack that emails the recipient ONLY when a successful SSH login comes from an IP
not on the allowlist. Requirements: "session optional"; always exit 0; do the
lookup + mail in a backgrounded subprocess (setsid) so a login is NEVER delayed or
blocked. Include user, source IP, reverse DNS, auth method, and a Location line
from ipgeo (Step 2). Test an allowlisted source (must be silent) and a
non-allowlisted source (must email, with the Location line). Do NOT allowlist by
key fingerprint. If there is no allowlist mechanism, skip this and note it.

=== CONSTRAINTS ===
- Scope is the digest + geo helper (+ optional SSH hook) only. No broader hardening.
- Idempotent: safe to re-run; update script/cron/PAM in place if they already exist.
- Back up any file you modify to <path>.bak-YYYY-MM-DD.
- If this host runs CSF: changing /etc/csf/csf.conf requires `systemctl restart lfd`
  (or `csf -ra`) to take effect — `csf -r` alone only reloads the firewall, not the
  lfd daemon. Also, CSF ships with RHEL log paths (/var/log/secure, /var/log/messages,
  /var/log/maillog); on Debian/Ubuntu these don't exist — if you touch CSF at all,
  sanity-check every *_LOG path in csf.conf points at a file that exists.
- No credentials or recipient-specific secrets in any script.

=== REPORT BACK ===
1. What you found monitorable vs. skipped (and why).
2. Every file created or changed, with paths.
3. The KPIs you chose and their thresholds.
4. ipgeo: which local country DB is in use, and today's API call count vs the budget.
5. Confirmation of a successful test send AND which folder it landed in (with the
   spam score if a filter reported one).
6. How to change the recipient address and the schedule.