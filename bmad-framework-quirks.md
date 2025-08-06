# BMAD-METHOD Quirks

I'm exploring the [BMAD-METHOD](https://github.com/bmadcode/BMAD-METHOD) for AI development. This page documents useful insights, quirks, and any issues I encounter along the way, along with potential solutions or workarounds.

## High-level flow

1. Work with a PM to create `PRD.md`
    - `*agent pm`
2. Have a chat with UX expert to create `front-end-spec.md`
    - `*agent ux`
3. Have a chat with architect
    - `*agent architect`

## Commands cheatsheet {#cheatsheet}

### Architect {#architect}
*   create-full-stack-architecture - Design complete fullstack system architecture
*   create-backend-architecture - Focus on backend system design and APIs
*   create-front-end-architecture - Design frontend architecture and components
*   create-brownfield-architecture - Architecture for existing system improvements
*   doc-out - Output complete document to current destination file
*   document-project - Comprehensive project documentation analysis
*   execute-checklist - Run architecture validation checklist (default: architect-checklist)
*research - Execute deep research on specific architectural topics
shard-prd - Break down architecture into focused PRD sections
yolo - Toggle Yolo Mode for rapid prototyping
exit - Complete current session and return to normal mode
### Product Owner {#po}

* ***execute-checklist-po** - Run the master Product Owner checklist
* ***shard-doc** - Break down a document into smaller components
* ***correct-course** - Execute course correction analysis
* ***create-epic** - Create new epic for brownfield projects
* ***create-story** - Create new user story from requirements
* ***doc-out** - Output full document to destination file
*  ***validate-story-draft** - Validate specific story files
* ***yolo** - Toggle Yolo Mode (currently OFF - confirmations enabled)
* ***exit** - Exit (confirm)