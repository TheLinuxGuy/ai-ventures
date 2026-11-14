# Prompt: Research and write a comprehensive macOS network observability app specification

## Your role and deliverable

Act as a principal macOS systems architect, network diagnostics engineer, and technical specification author.

Your task is to research, resolve architectural details, perform small bounded feasibility experiments where appropriate, and write a comprehensive `SPEC.md` for agents to implement a complete application.

Do not build the application yet. Your deliverable is an implementation-ready specification grounded in verified platform capabilities, explicit tradeoffs, measurable acceptance criteria, and a phased implementation plan.

Do not merely restate these requirements or produce an aspirational feature list. Investigate the difficult parts, choose defensible approaches, and explain your decisions.

Ask questions only when an unresolved decision materially affects feasibility, scope, safety, or architecture. Otherwise, make a reasonable recommendation and record the assumption.

## 1. Product purpose

Design a lightweight, local-first macOS application for:

- Tracking and retaining historical application connections and bandwidth.
- Diagnosing slow websites, applications, and network traffic.
- Explaining traffic paths, latency, service degradation, and potential Zscaler-related problems.
- Producing evidence-rich diagnostic reports that can be shared with Zscaler or internal support teams.

Network security is a long-term goal, but the initial release is observational and diagnostic, not an enforcement product.

### Target platform

- Apple Silicon only.
- Target macOS Golden Gate 27 as named by the requester. Verify its exact official version, SDK availability, and relevant capabilities rather than assuming the name establishes API support.
- Older macOS support is optional, not required.
- Administrator access, approved privileged helpers, and Network Extensions are acceptable where justified.
- Consider corporate-managed deployment, signing, notarization, entitlements, extension approval, and MDM requirements.

### Operating environments

The app must be useful when:

- Zscaler Client Connector is installed and ZIA is enabled.
- ZCC is installed but ZIA is disabled.
- Zscaler is not installed.
- Network configuration or Zscaler state changes during operation.

The current ZIA environment uses tunnel-based traffic forwarding and SSL inspection, with a planned migration to Transparent Proxy-based Traffic Interception (TPTI).

Research coexistence and visibility across:

- Zscaler tunnel forwarding.
- TPTI.
- Route-based tunnels.
- Explicit and transparent proxies.
- PAC-based proxy selection and bypass.
- System and application-specific proxy configurations.
- MASQUE, HTTP/3, QUIC, and relevant encapsulation.
- Other logical interfaces and overlapping network extensions.

Do not conflate the ability to coexist with a mechanism with the ability to inspect its inner traffic.

If a requested combination is unsupported, restricted, or unobservable, explicitly explain why and identify the best achievable alternative.

## 2. Review these reference applications first

Review documentation and relevant implementation files:

- https://github.com/Apiruck-Corp/current
- https://github.com/kevinabouhanna/NetworkMonitor

Treat them as references, not predetermined foundations.

For each, document:

- Repository identity, upstream relationships, reviewed commit, and license.
- Architecture and data collection mechanisms.
- Process and application attribution.
- Interface and bandwidth accounting.
- Network Extension and privilege requirements.
- Historical storage.
- Performance and accuracy limitations.
- Useful patterns to adopt and approaches to avoid.
- Whether reuse is technically and legally appropriate.

Distinguish implemented behavior from documentation claims, planned features, and untested assumptions.

An earlier source review suggested that Current is primarily interface-oriented, while NetworkMonitor combines process/socket accounting with a filtering extension. Verify those findings independently. Neither is established as satisfying this product’s Zscaler compatibility or diagnostic requirements.

## 3. Traffic visibility and attribution

The product ambition is device-wide network visibility. Translate this into a testable coverage contract, not an unsupported promise to know everything.

Investigate coverage of:

- TCP, UDP, QUIC, IPv4, IPv6, DNS, and other relevant traffic.
- Short-lived connections and processes.
- Background services, helpers, subprocesses, and independently launched agents.
- Shared system services and brokered connections.
- Localhost, LAN, Internet, multicast, and link-local traffic.
- Traffic before, inside, and after proxying or encapsulation where observable.

Associate traffic with application context and signing identity, including applicable:

- Process instance identity and lifetime.
- Executable path and bundle identity.
- Parent/child and spawn relationships.
- Signing identifier, Team ID, and signature validation state.
- Application version.
- Helpers and related processes.

Avoid PID-reuse errors and unjustified attribution through parent relationships or shared services.

Represent attribution confidence, provenance, and ambiguity explicitly. Include unattributed and shared categories.

## 4. Traffic-path reconstruction

Determine the best achievable way to classify traffic as:

- Direct to destination.
- Forwarded through Zscaler.
- Carried by another tunnel or proxy.
- Explicitly bypassed, when evidence establishes this.
- Unknown or ambiguous.

Where possible, associate records with:

- Logical and physical interfaces.
- Proxy/tunnel endpoints.
- Observed destination versus original intended destination.
- Route, proxy, PAC, and network configuration effective at that time.
- Network transitions and configuration changes.

Distinguish:

- Observed path.
- Expected path inferred from configuration.
- Confirmed bypass and its reason.
- Suspected bypass.
- Unresolved path.

Do not assume traffic on a tunnel interface proves which application originated it, or that direct traffic proves intentional bypass.

Account for tunnels multiplexing many inner flows and for proxy connections that obscure original destinations. Model inner/outer relationships where possible without double-counting.

## 5. Bandwidth and session modeling

Track:

- Upload and download.
- Per-application and process-family usage.
- Interface totals.
- LAN versus Internet usage.
- Logical/tunnel versus physical usage.
- Historical usage by network.
- Application-level versus on-wire accounting where available.
- Encapsulation overhead and unattributed differences.

The main UI should emphasize real-world interface throughput, such as Wi-Fi upload/download speeds. Detailed views and exports should expose richer accounting.

Research and recommend a session model appropriate for troubleshooting and reporting. Consider separate entities for:

- Process lifetimes.
- Transport flows.
- Proxy/tunnel connections.
- Application requests.
- Browser navigations.
- Diagnostic incidents.

Do not force these into a single ambiguous “session” abstraction.

Preserve enough structured data to support future reporting changes without redesigning collection. Define which details are retained, aggregated, expired, or unavailable; this is not a requirement to retain every raw event forever.

## 6. Performance and user-experience diagnostics

Investigate collection of:

- Transport RTT and observed latency.
- DNS lookup timing.
- Connection establishment.
- TLS handshake timing.
- Request/response timing and time to first byte.
- Throughput, connection duration, retransmissions, loss indicators, jitter, and stalls where measurable.
- Browser navigation and page-experience metrics.
- Wi-Fi/interface health and relevant network changes.
- System resource pressure that may explain apparent network slowness.

Chrome and Edge are the browser priorities. An optional browser extension or additional instrumentation is acceptable.

Define correlation between browser observations and OS-level records, including connection reuse, HTTP/2 and HTTP/3 multiplexing, caching, service workers, and timing ambiguity.

For every metric, specify:

- Meaning and unit.
- Data source.
- Passive measurement, active probe, estimate, or inference.
- Sampling and timing accuracy.
- Coverage limitations.
- Missing-data behavior.
- Expected overhead.

Never substitute a probe to an unrelated endpoint for the user’s actual website experience without labeling that distinction.

Evaluate whether basic per-app CPU/memory tracking and system resource-pressure signals are justified. Recommend a lightweight collection strategy rather than automatically collecting high-frequency resource metrics.

## 7. Zscaler diagnostics and upstream policy outcomes

Investigate diagnosis of:

- Tunnel degradation.
- MTU mismatch, fragmentation, and PMTU black holes.
- DNS or connection-establishment delays.
- TLS inspection or interception.
- QUIC/HTTP/3 fallback and protocol changes.
- Proxy/tunnel path changes.
- Slow throughput, repeated reconnects, and stalls.

Determine how the app can identify destinations subject to SSL inspection. Distinguish observed certificates or interception signals from authoritative policy knowledge.

Investigate whether latency introduced by Zscaler interception can be measured or estimated. Separate:

- Direct measurements.
- Controlled comparisons.
- Correlation.
- Unsupported causal attribution.

Do not claim that an intercepted connection’s total latency equals latency caused by inspection. Identify confounders and safe validation methods.

### Upstream allow/block policies

The initial release should record traffic allowed or blocked by Zscaler policies when reliable evidence is available.

Research potential evidence sources, such as permitted local diagnostics, browser observations, block responses, and authorized Zscaler-side log/API integrations.

Distinguish:

- Confirmed Zscaler policy block.
- Confirmed Zscaler allow decision.
- Successful connection with no authoritative policy decision.
- Suspected filtering.
- Ordinary connection failure.
- Unknown.

Do not equate successful traffic with an authoritative allow-policy event or timeouts with policy blocks.

Do not assume access to tenant APIs, administrator credentials, proprietary interfaces, or cloud logs. Specify dependencies and useful degraded operation without them.

All diagnoses must be labeled confirmed, probable, or inconclusive, supported by evidence and alternative explanations.

## 8. Local database and disk efficiency

A local database is mandatory.

Design storage to minimize disk consumption while preserving useful diagnostic evidence and historical reporting.

Do not optimize disk in isolation at the expense of excessive CPU, battery usage, write amplification, or unusable queries.

Evaluate and select an appropriate storage approach. Specify:

- Schema and entity relationships.
- Stable identities and event correlation.
- Timestamp handling and clock changes.
- Index strategy.
- Batching and write frequency.
- Retention tiers and aggregation/downsampling.
- Compression where justified.
- Deduplication and normalization.
- Database, journal/WAL, temporary-file, and export growth.
- Compaction and actual disk-space reclamation.
- Crash recovery and schema migrations.
- Disk-pressure and low-free-space behavior.
- Configurable storage caps.
- Data loss, sampling gaps, and pruning visibility.

Recommend default retention and storage budgets with estimates for idle, typical, and heavy-use machines. State workload assumptions and estimated bytes per record.

Explicitly resolve the tension between rich history and minimal disk usage. Define what remains queryable after detailed records expire.

Raw packet capture must not be the default historical storage mechanism. If supported for troubleshooting, make it bounded, opt-in, and separately retained.

## 9. Resource efficiency and privacy

Use native frameworks and lightweight architectural choices by default, but justify technology selection with evidence.

Propose measurable budgets for:

- Idle and active CPU.
- Memory.
- Battery impact.
- Disk growth and writes.
- Wakeups.
- Collection lag.
- Diagnostic-mode overhead.

Budget all components together, including helpers, extensions, browser instrumentation, subprocesses, and database work.

Specify adaptive behavior for sleep/wake, Low Power Mode, battery operation, high traffic, resource pressure, and a closed UI.

Recommend privacy defaults covering domains, URLs, query strings, network identifiers, certificates, packet metadata, and captured content.

The database must be local. Do not introduce cloud collection, telemetry, external probes, or enrichment services without explicitly documenting their need, transmitted data, consent, and offline behavior.

## 10. Reporting and UI

Specify:

- Menu-bar and/or desktop experience, with a justified recommendation.
- Live interface throughput.
- Historical application connections and bandwidth.
- Application identity and attribution confidence.
- Traffic-path and interface views.
- Performance timelines.
- Diagnostic incidents and supporting evidence.
- Search, filtering, retention controls, and storage usage.
- Collection-health and visibility-gap indicators.

Design exportable diagnostic reports suitable for Zscaler and internal support.

Reports should include selected time ranges, affected applications/destinations, topology/configuration context, observations, evidence provenance, confidence, missing data, and relevant software versions.

Separate observations from interpretations. Include redaction, preview-before-export, reproducible machine-readable data, and a human-readable summary. Recommend formats and size limits.

## 11. Future enforcement—not initial implementation

Preserve an architectural path toward:

- Application rules.
- IP/CIDR rules.
- Domain/subdomain rules.
- Ports and protocols.
- LAN versus Internet policies.
- Network-specific policies.
- Full-URL rules where technically feasible.
- Optional prompting.
- HTTP header injection where technically feasible and appropriate.

Initial behavior is observation-only: no blocking, prompts, header modification, or interference with Zscaler.

Future default policy should allow traffic unless configured otherwise.

Research feasibility boundaries, especially encrypted traffic, full URLs, header modification, policy conflicts, and fail-open/fail-closed behavior. Do not prebuild speculative enforcement machinery or require TLS interception merely to preserve future optionality.

## 12. Research and experiment boundaries

Use primary sources wherever possible. Cite platform documentation, vendor documentation, and exact repository files/commits.

Maintain a capability matrix containing:

- Requirement.
- Proposed API/data source.
- Required permissions/entitlements.
- OS availability.
- Coverage and accuracy.
- Resource implications.
- Zscaler coexistence considerations.
- Evidence and confidence.
- Proof-of-concept gate.
- Acceptance test.
- Fallback or explicit limitation.

Small bounded feasibility experiments are permitted when safe, reversible, and relevant. Record their purpose, method, results, and limits.

Obtain explicit approval before installing or activating extensions/helpers, changing network settings, modifying Zscaler, accessing sensitive traffic contents, or running disruptive tests. Do not disable or bypass corporate security controls.

An unperformed experiment is a validation requirement, not a successful result.

## 13. Required SPEC structure

Include at minimum:

- Executive summary and product priorities.
- Goals, non-goals, assumptions, and terminology.
- Reference-app findings and reuse decision.
- Feasibility/coverage matrix.
- Architecture, component responsibilities, trust boundaries, and data-flow diagrams.
- Collection mechanisms and degraded modes.
- Application identity, attribution, path, and session models.
- Metrics and diagnostic methodology.
- Zscaler compatibility and policy-evidence design.
- Database schema, retention, and storage estimates.
- Resource budgets and benchmark methodology.
- Privacy, security, permissions, installation, and updates.
- UI workflows and reporting/export contracts.
- Failure handling and collection-health observability.
- Test strategy and measurable acceptance criteria.
- Phased implementation plan with dependencies and feasibility gates.
- Risks, unresolved questions, and explicit unsupported capabilities.
- Sources and experiment results.

The implementation plan should establish high-risk collection and Zscaler coexistence feasibility before investing heavily in UI. Each phase should have concrete outputs and exit criteria.

**Definition of success:** implementation agents can use the spec without inventing foundational architecture, while users can understand exactly what the app measures, estimates, misses, stores, and can credibly diagnose.
