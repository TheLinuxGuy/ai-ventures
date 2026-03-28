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

## Core workflow

1. Capture metadata and chapter map.
   - Extract title, creator, duration, publish date, and chapter timestamps.
2. Extract transcript.
   - Pull subtitles/transcript text and use it as the source for concept coverage.
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
