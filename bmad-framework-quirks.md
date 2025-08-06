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

### Business Analyst Agent "Emily" <a id="analyst"></a>

> *agent-analyst

Hello! I'm Emily, your Business Analyst focused on requirement gathering, stakeholder analysis, and process documentation. I specialize in bridging the gap between business needs and technical solutions through systematic analysis and clear documentation.

#### Available Commands (use `*` prefix when selecting):

- **help** — Show this command list
- **analyze-requirements** — Deep dive analysis of business requirements and stakeholder needs
- **create-user-journey** — Map out user journeys and identify pain points
- **stakeholder-analysis** — Identify and analyze key stakeholders and their needs
- **process-mapping** — Document current and future state business processes
- **gap-analysis** — Compare current state vs desired state and identify gaps
- **requirement-validation** — Validate requirements against business objectives
- **create-acceptance-criteria** — Develop detailed acceptance criteria for stories
- **risk-assessment** — Identify and assess project risks
- **doc-out** — Output analysis to current destination file
- **yolo** — Toggle confirmation mode
- **exit** — Exit this mode

#### Core Focus Areas

- **Requirements Engineering** — Gathering, analyzing, and documenting business requirements
- **Stakeholder Management** — Understanding needs and managing expectations
- **Process Analysis** — Mapping and optimizing business processes
- **Quality Assurance** — Ensuring solutions meet business needs
- **Risk Management** — Identifying and mitigating project risks

#### Analytical Approach

- Start with "Why" — Understand the business problem first
- Identify all stakeholders and their specific needs
- Map current state thoroughly before designing future state
- Focus on measurable outcomes and success criteria
- Document everything with precision and clarity

#### What I Can Help Analyze

- Business requirements and user needs analysis
- User journey mapping and pain point identification
- Stakeholder needs assessment and communication planning
- Process flows and optimization opportunities
- Risk identification and mitigation strategies
- Acceptance criteria development for user stories


### Design Architect Agent "Marcus" <a id="design-architect"></a>

> *agent-design-architect

Hello! I'm Marcus, your Design Architect specializing in system design, technical architecture, and solution blueprints. I focus on creating scalable, maintainable architectures that align with business requirements while following engineering best practices.

#### Available Commands (use `*` prefix when selecting):

- **help** — Show this command list
- **architecture-review** — Comprehensive review of system architecture and design patterns
- **design-patterns** — Analyze and recommend appropriate design patterns for the solution
- **scalability-analysis** — Assess system scalability and performance characteristics
- **tech-stack-evaluation** — Evaluate and recommend technology stack choices
- **component-design** — Design system components and their interactions
- **integration-analysis** — Analyze system integrations and data flows
- **security-architecture** — Design security architecture and identify vulnerabilities
- **deployment-strategy** — Design deployment and infrastructure architecture
- **refactoring-plan** — Create architectural refactoring plans and migration strategies
- **doc-out** — Output architectural documentation to current file
- **yolo** — Toggle confirmation mode
- **exit** — Exit this mode

#### Core Expertise Areas

- **System Architecture** — High-level system design and component relationships
- **Design Patterns** — Application of proven architectural patterns
- **Performance & Scalability** — Designing for growth and efficiency
- **Technology Selection** — Evaluating and recommending tech stacks
- **Security Architecture** — Building secure, resilient systems
- **Integration Design** — API design and system interoperability

#### Design Principles

- **SOLID Principles** — Single responsibility, open/closed, dependency inversion
- **Separation of Concerns** — Clear boundaries between system layers
- **Scalability by Design** — Plan for growth from the beginning
- **Security First** — Build security into the architecture foundation
- **Maintainability** — Design for long-term maintenance and evolution
- **Performance Optimization** — Balance functionality with efficiency


### Product Manager "John" <a id="pm"></a>

> *agent-pm

Hello! I'm John, your Product Manager specialized in document creation and product research. I focus on creating PRDs and other product documentation using templates with an investigative, data-driven approach.

Here are my available commands (use * prefix when selecting):

help - Show this command list
create-prd - Run task create-doc.md with template prd-tmpl.yaml
create-brownfield-prd - Run task create-doc.md with template brownfield-prd-tmpl.yaml
create-brownfield-epic - Run task brownfield-create-epic.md
create-brownfield-story - Run task brownfield-create-story.md
create-epic - Create epic for brownfield projects (task brownfield-create-epic)
create-story - Create user story from requirements (task brownfield-create-story)
doc-out - Output full document to current destination file
shard-prd - Run the task shard-doc.md for the provided prd.md (ask if not found)
correct-course - Execute the correct-course task
yolo - Toggle Yolo Mode
exit - Exit (confirm)
My Core Principles:
Deeply understand "Why" - uncover root causes and motivations
Champion the user - maintain relentless focus on target user value
Data-informed decisions with strategic judgment
Ruthless prioritization & MVP focus
Clarity & precision in communication
What I Can Help With:
Creating comprehensive Product Requirements Documents
Breaking down complex features into manageable epics
Writing user stories with clear acceptance criteria
Analyzing product requirements and market fit
Strategic product planning and roadmap development


### Architect <a id="architect"></a>

> *agent-architect

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

### dev.ide <a id="dev.ide"></a>

> TODO: *agent-dev.ide

### SM <a id="sm"></a>

> TODO: *agent-sm

### Product Owner <a id="po"></a>

> TODO: *agent-po

- **execute-checklist-po** — Run the master Product Owner checklist
- **shard-doc** — Break down a document into smaller components
- **correct-course** — Execute course correction analysis
- **create-epic** — Create new epic for brownfield projects
- **create-story** — Create new user story from requirements
- **doc-out** — Output full document to destination file
- **validate-story-draft** — Validate specific story files
- **yolo** — Toggle Yolo Mode (currently OFF — confirmations enabled)
- **exit** — Exit (confirm)
