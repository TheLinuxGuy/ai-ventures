---
name: claude-youtube-summarize
description: "Use when converting a full YouTube video or course into a complete markdown reference with chapter coverage, prerequisites, feature guidance, when-to-use advice, examples, and overlap-aware merge updates to existing repo docs."
---

# Claude YouTube Summarize

## Purpose

Convert a YouTube course into a practical repository reference document that is easy to use during real work.

## Use this skill when

- You want complete chapter-by-chapter notes, not a short summary.
- You need actionable guidance, including prerequisites and when each feature should be used.
- You want overlap checks and clean merging with existing documentation.

## Inputs required

- Video URL
- Target output file path
- Existing related docs to compare for overlap
- Preferred output style (short tactical, long strategic, or both)

## Output routing rules

Choose the target path based on what the video is primarily about:

- Put summaries in `claude/plugins/` when the video is dedicated to a single plugin or a plugin-specific workflow.
- Put summaries in `claude/skills/` when the video is dedicated to a single skill or a skill-specific workflow.
- Put summaries in `claude/` for general Claude setup, workflow, or course videos that are not centered on one plugin or skill.

If a video meaningfully spans multiple topics, keep the main reference in the most specific matching folder and add cross-links from the broader indexes.

## Expected outputs

1. A new markdown reference file for the video.
2. Optional updates to related markdown files with merged overlap notes.
3. Navigation links added where needed so the new file is discoverable.

## Fetching YouTube content

Don't fetch YouTube URLs with WebFetch or WebSearch: YouTube requires browser rendering and blocks static fetchers. Use `yt-dlp` via the Bash tool to extract metadata and transcripts locally.

**Always pass `--cookies-from-browser brave` on every `yt-dlp` call (default, not a fallback).** Without it, subtitle downloads routinely fail with `HTTP Error 429: Too Many Requests`, and retries, sleeps, and alternate player clients (e.g. `web_safari`) do not help. Reading the user's logged-in Brave session fixes it on the first attempt.

```bash
# Get video metadata + chapter timestamps
yt-dlp --cookies-from-browser brave --dump-json "VIDEO_URL" > /tmp/yt_meta.json

# Download auto-generated subtitles as plain text
yt-dlp --cookies-from-browser brave --write-auto-sub --sub-format vtt --sub-lang en --skip-download \
  -o "/tmp/yt_transcript" "VIDEO_URL"

# Convert VTT to readable text (strip headers, timestamps, inline tags; dedupe rolling captions, keep order)
cat /tmp/yt_transcript.en.vtt | grep -v "^WEBVTT" | grep -vE "^(Kind|Language):" \
  | grep -v -- "-->" | sed 's/<[^>]*>//g' | grep -v "^[[:space:]]*$" \
  | awk '!seen[$0]++' > /tmp/yt_clean.txt
```

Cookie rules:
- Cookies are read in-memory by `yt-dlp` from the local browser profile. Never export them to a file, print them, or commit them.
- If Brave is unavailable, swap in another installed browser (`chrome`, `firefox`, `safari`, `edge`); keep the same flag position.
- macOS may show a Keychain prompt on first use; the user must approve it.
- Don't loop on 429 without cookies; add the flag instead.

### Whisper pass (default: source of truth, captions verify)

Always run both transcripts. YouTube auto-captions mangle product names and jargon (e.g. "scorers" → "estimates", "harnesses" → "tools"), so the local Whisper transcript is the source of truth and the VTT captions are the cross-check.

- Start Whisper in the background first (`run_in_background`), then fetch metadata + captions while it runs.
- Use the Whisper text for all concept coverage, names, and quotes.
- Use the cleaned VTT as verification: it has no hallucinations, so diff for segments Whisper dropped, looped, or invented (e.g. a stray "Music" at the start or "Thank you" at the end).
- If Whisper and captions disagree on a name or number, prefer Whisper, and mark unverifiable names as "as heard" in the reference.
- If Whisper is unavailable or fails, fall back to the VTT transcript and say so in the reference's caveats.

```bash
# One-time install (Apple Silicon; isolated, needs ffmpeg + uv)
uv tool install mlx-whisper

# Fresh scratch dir; 16 kHz mono wav
mkdir -p /tmp/yt_audio
yt-dlp --cookies-from-browser brave -f bestaudio -x --audio-format wav \
  --postprocessor-args "ffmpeg:-ar 16000 -ac 1" -o "/tmp/yt_audio/talk.%(ext)s" "VIDEO_URL"

# Transcribe (~3 min for a 22 min talk); first run downloads the model (~1.6 GB)
mlx_whisper /tmp/yt_audio/talk.wav --model mlx-community/whisper-large-v3-turbo --language en \
  --output-dir /tmp/yt_audio --output-format txt --output-name whisper \
  --initial-prompt "SPEAKER, PRODUCT, TERMS from title/description"
```

- Seed `--initial-prompt` with names and jargon from the video title and description to improve spelling.
- Whisper still writes "Cloud Code" for Claude Code; fix by hand.
- Delete `/tmp/yt_audio` when done.

Parse `/tmp/yt_meta.json` for: `.title`, `.uploader`, `.duration_string`, `.upload_date`, `.chapters[]` (title + start_time).
Use the Whisper transcript as the source for all concept coverage; use the cleaned VTT only to cross-check it.

## Core workflow

1. Capture metadata and chapter map.
   - Run `yt-dlp --cookies-from-browser brave --dump-json` to get title, creator, duration, publish date, and chapter timestamps.
   - Parse `.chapters[]` from the JSON for the chapter list.
2. Extract transcripts (both, by default).
   - Start the local Whisper transcription in the background (see "Whisper pass").
   - Run `yt-dlp --cookies-from-browser brave --write-auto-sub` to download subtitles and clean the VTT to plain text.
   - When Whisper finishes, use it as the source for concept coverage and use the VTT to cross-check for dropped or invented segments.
3. Build concept map.
   - Convert chapters into concepts and infer practical usage boundaries.
4. Write structured markdown.
   - For each chapter, include:
     - Concept
     - Prerequisites
     - When to use
     - Example
5. Merge overlaps.
   - Compare existing docs and avoid duplicate sections.
   - Add a compact overlap section explaining what is tactical versus strategic.
6. Wire navigation.
   - Add links from existing docs so users can find the new reference quickly.
   - Add or update the relevant folder index first when the video is plugin-specific or skill-specific.
7. Clean temporary artifacts.
   - Remove transcript dump files and keep only durable markdown references.

## Suggested markdown structure

- Title and source URL
- Purpose
- Video metadata
- Global prerequisites
- Official docs
- Overlap with existing notes
- Chapter-by-chapter reference
- Practical implementation checklist
- Companion files
- Notes and caveats

## Quality checklist

- Covers every chapter from the source metadata.
- Every chapter includes prerequisites, when-to-use, and example.
- Overlap with existing docs is merged or clearly called out.
- Links are valid and navigation is easy.
- Output is readable in browser markdown renderers.

## Constraints

- Do not copy long transcript passages verbatim.
- Prefer paraphrased, actionable summaries.

## Example invocation prompt

Create a full reference markdown from this YouTube course URL. Cover every chapter and include prerequisites, when-to-use, and examples per concept. Compare with existing docs in this repo, merge overlaps for readability, and add cross-links so the new reference is easy to find.
