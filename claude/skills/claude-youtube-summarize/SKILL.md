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

## Expected outputs

1. A new markdown reference file for the video.
2. Optional updates to related markdown files with merged overlap notes.
3. Navigation links added where needed so the new file is discoverable.

## CRITICAL: How to fetch YouTube content

**Never fetch YouTube URLs directly** (WebFetch, WebSearch, etc.) — YouTube requires browser rendering and blocks static fetchers.

**Always use `yt-dlp`** via the Bash tool to extract metadata and transcripts locally:

```bash
# Get video metadata + chapter timestamps
yt-dlp --dump-json "VIDEO_URL" > /tmp/yt_meta.json

# Download auto-generated subtitles as plain text
yt-dlp --write-auto-sub --sub-format vtt --sub-lang en --skip-download \
  -o "/tmp/yt_transcript" "VIDEO_URL"

# Convert VTT to readable text (strip timestamps)
cat /tmp/yt_transcript.en.vtt | grep -v "^WEBVTT" | grep -v "^[0-9]" \
  | grep -v "^[0-9][0-9]:" | grep -v "^$" | sort -u > /tmp/yt_clean.txt
```

Parse `/tmp/yt_meta.json` for: `.title`, `.uploader`, `.duration_string`, `.upload_date`, `.chapters[]` (title + start_time).
Use the cleaned transcript as the source for all concept coverage.

## Core workflow

1. Capture metadata and chapter map.
   - Run `yt-dlp --dump-json` to get title, creator, duration, publish date, and chapter timestamps.
   - Parse `.chapters[]` from the JSON for the chapter list.
2. Extract transcript.
   - Run `yt-dlp --write-auto-sub` to download subtitles locally.
   - Clean the VTT file to plain text; use it as the source for concept coverage.
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
- Keep recommendations realistic and safe for production workflows.

## Example invocation prompt

Create a full reference markdown from this YouTube course URL. Cover every chapter and include prerequisites, when-to-use, and examples per concept. Compare with existing docs in this repo, merge overlaps for readability, and add cross-links so the new reference is easy to find.
