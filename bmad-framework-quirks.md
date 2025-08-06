# BMAD-METHOD Quirks

I'm exploring the [BMAD-METHOD](https://github.com/bmadcode/BMAD-METHOD) for AI development. This page documents useful insights, quirks, and any issues I encounter along the way, along with potential solutions or workarounds.

## High-level Flow

1. Work with a PM to create `PRD.md`
    - `*agent pm`
2. Chat with a UX expert to create `front-end-spec.md`
    - `*agent ux`
3. Chat with an architect
    - `*agent architect`

## Commands Cheatsheet

### Product Manager "John" <a id="pm"></a>

- **help** — Show this command list
- **create-prd** — Run task `create-doc.md` with template `prd-tmpl.yaml`
- **create-brownfield-prd** — Run task `create-doc.md` with template `brownfield-prd-tmpl.yaml`
- **create-brownfield-epic** — Run task `brownfield-create-epic.md`
- **create-brownfield-story** — Run task `brownfield-create-story.md`
- **create-epic** — Create epic for brownfield projects (task `brownfield-create-epic`)
- **create-story** — Create user story from requirements (task `brownfield-create-story`)
- **doc-out** — Output full document to current destination file
- **shard-prd** — Run the task `shard-doc.md` for the provided `prd.md` (ask if not found)
- **correct-course** — Execute the `correct-course` task
- **yolo** — Toggle Yolo Mode
- **exit** — Exit (confirm)

### Architect <a id="architect"></a>

- **create-full-stack-architecture** — Design complete fullstack system architecture
- **create-backend-architecture** — Focus on backend system design and APIs
- **create-front-end-architecture** — Design frontend architecture and components
- **create-brownfield-architecture** — Architecture for existing system improvements
- **doc-out** — Output complete document to current destination file
- **document-project** — Comprehensive project documentation analysis
- **execute-checklist** — Run architecture validation checklist (default: architect-checklist)
- **research** — Execute deep research on specific architectural topics
- **shard-prd** — Break down architecture into focused PRD sections
- **yolo** — Toggle Yolo Mode for rapid prototyping
- **exit** — Complete current session and return to normal mode

### Product Owner <a id="po"></a>

- **execute-checklist-po** — Run the master Product Owner checklist
- **shard-doc** — Break down a document into smaller components
- **correct-course** — Execute course correction analysis
- **create-epic** — Create new epic for brownfield projects
- **create-story** — Create new user story from requirements
- **doc-out** — Output full document to destination file
- **validate-story-draft** — Validate specific story files
- **yolo** — Toggle Yolo Mode (currently OFF — confirmations enabled)
- **exit** — Exit (confirm)
