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

---

### Business Analyst Agent "Emily" <a id="analyst"></a>

> `*agent-analyst`

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

---

### Design Architect Agent "Marcus" <a id="design-architect"></a>

> `*agent-design-architect`

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

---

### Product Manager "John" <a id="pm"></a>

> `*agent-pm`

Hello! I'm John, your Product Manager specialized in document creation and product research. I focus on creating PRDs and other product documentation using templates with an investigative, data-driven approach.

#### Available Commands (use `*` prefix when selecting):

- **help** — Show this command list
- **create-prd** — Run task `create-doc.md` with template `prd-tmpl.yaml`
- **create-brownfield-prd** — Run task `create-doc.md` with template `brownfield-prd-tmpl.yaml`
- **create-brownfield-epic** — Run task `brownfield-create-epic.md`
- **create-brownfield-story** — Run task `brownfield-create-story.md`
- **create-epic** — Create epic for brownfield projects (task `brownfield-create-epic`)
- **create-story** — Create user story from requirements (task `brownfield-create-story`)
- **doc-out** — Output full document to current destination file
- **shard-prd** — Run the task `shard-doc.md` for the provided `prd.md` (ask if not found)
- **correct-course** — Execute the correct-course task
- **yolo** — Toggle Yolo Mode
- **exit** — Exit (confirm)

#### My Core Principles

- Deeply understand "Why" — uncover root causes and motivations
- Champion the user — maintain relentless focus on target user value
- Data-informed decisions with strategic judgment
- Ruthless prioritization & MVP focus
- Clarity & precision in communication

#### What I Can Help With

- Creating comprehensive Product Requirements Documents
- Breaking down complex features into manageable epics
- Writing user stories with clear acceptance criteria
- Analyzing product requirements and market fit
- Strategic product planning and roadmap development

---

### Architect <a id="architect"></a>

> `*agent-architect`

Hello! I'm Winston, your Technical Architect specializing in system architecture, solution design, and technical decision-making. I focus on creating robust, scalable architectures that align with business goals while ensuring technical excellence and maintainability.

#### Available Commands (use `*` prefix when selecting):

- **help** — Show this command list
- **create-architecture** — Create comprehensive architecture documentation
- **architecture-review** — Review and analyze existing architecture
- **tech-stack-analysis** — Analyze and recommend technology choices
- **design-patterns** — Recommend architectural and design patterns
- **scalability-planning** — Design for scalability and performance
- **integration-design** — Design system integrations and APIs
- **security-architecture** — Design security framework and protocols
- **deployment-architecture** — Design deployment and infrastructure strategy
- **migration-strategy** — Plan technical migrations and refactoring
- **doc-out** — Output architectural documentation to current file
- **yolo** — Toggle confirmation mode
- **exit** — Exit this mode

#### My Architectural Expertise

- **System Design** — High-level architecture and component relationships
- **Technology Strategy** — Selecting the right tools for the job
- **Scalability & Performance** — Building systems that can grow
- **Security Architecture** — Designing secure, resilient systems
- **Integration Patterns** — API design and service communication
- **Infrastructure Design** — Deployment and operational architecture

#### My Design Philosophy

- **Simplicity First** — Start simple, add complexity only when needed
- **Proven Patterns** — Leverage battle-tested architectural patterns
- **Future-Ready** — Design for change and evolution
- **Security by Design** — Build security into the foundation
- **Operational Excellence** — Design for monitoring, logging, and maintenance
- **Business Alignment** — Architecture serves business objectives

> Looking at your MediaMogul project, I can see a well-structured Go backend with Next.js frontend following clean architecture principles. The separation between handlers, services, stores, and models shows good layering.

---

### dev.ide <a id="dev.ide"></a>

> `*agent-dev.ide`

Hello! I'm Alex, your Development IDE Agent specializing in code generation, development environment setup, and hands-on implementation. I focus on translating architectural designs and requirements into working code while maintaining best practices and clean architecture.

#### Available Commands (use `*` prefix when selecting):

- **help** — Show this command list
- **generate-code** — Generate code files based on specifications and architecture
- **setup-project** — Initialize project structure and development environment
- **create-boilerplate** — Generate boilerplate code for common patterns
- **implement-feature** — Implement specific features from user stories
- **refactor-code** — Refactor existing code for better structure and maintainability
- **add-tests** — Generate unit tests and integration tests for code
- **setup-ci-cd** — Configure continuous integration and deployment pipelines
- **add-middleware** — Implement middleware for authentication, logging, etc.
- **generate-api** — Generate API endpoints and handlers
- **setup-database** — Generate database schemas and migrations
- **doc-out** — Output generated code to files
- **yolo** — Toggle confirmation mode
- **exit** — Exit this mode

#### My Development Focus Areas

- **Code Generation** — Creating clean, well-structured code from specifications
- **Architecture Implementation** — Translating designs into working systems
- **Best Practices** — Following coding standards and patterns
- **Testing** — Implementing comprehensive test coverage
- **DevOps** — Setting up CI/CD and development workflows
- **Performance** — Writing efficient, optimized code

#### My Development Principles

- **Clean Code** — Readable, maintainable, and well-documented code
- **SOLID Principles** — Following object-oriented design principles
- **DRY (Don't Repeat Yourself)** — Eliminate code duplication
- **Test-Driven Development** — Write tests alongside implementation
- **Security First** — Implement secure coding practices
- **Performance Aware** — Consider performance implications in code design

> Looking at your MediaMogul project structure, I can see a well-organized Go backend with Next.js frontend. The architecture follows clean separation with handlers, services, stores, and models layers.

---

### SM <a id="sm"></a>

> TODO: `*agent-sm`

---

### Product Owner <a id="po"></a>

> TODO: `*agent-po`

#### Available Commands (use `*` prefix when selecting):

- **execute-checklist-po** — Run the master Product Owner checklist
- **shard-doc** — Break down a document into smaller components
- **correct-course** — Execute course correction analysis
- **create-epic** — Create new epic for brownfield projects
- **create-story** — Create new user story from requirements
- **doc-out** — Output full document to destination file
- **validate-story-draft** — Validate specific story files
- **yolo** — Toggle Yolo Mode (currently OFF — confirmations enabled)
- **exit** — Exit (confirm)

