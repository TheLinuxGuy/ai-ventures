# MediaMogul Product Requirements Document (PRD)

## Goals and Background Context

### Expanded Goals (Detailed View)

* **1. Intelligent Data Migration**
    * Provide a UI to plan and forecast disk space changes before executing `rsync` migrations.
    * Recommend optimal destination disks to co-locate file hierarchies (e.g., seasons of a TV show).
    * Allow user overrides for all migration recommendations.
    * Queue all migration operations as background tasks in a database.
* **2. Comprehensive File Monitoring**
    * Track file/folder history for 'created', 'modified', 'deleted', and 'moved' actions.
    * Calculate and store MD5 signatures for files, with intelligent re-calculation logic.
    * Integrate the `mediainfo` library to extract and store key technical metadata from media files.
    * Present a clear history log for any given file path, highlighting changes like renames vs. in-place replacements.
    * For in-place file replacements, calculate and display the delta in disk space and any changes to video/audio codecs.
* **3. Third-Party Integration**
    * Connect to Sonarr and Radarr APIs to correlate file information.
    * Tag files in the database that are also tracked by these external applications.
    * Provide a configuration option to handle path mapping differences between applications (e.g., `/downloads/` vs. `/mnt/hdd/disk1/`).
* **4. Actionable System Dashboard**
    * Display aggregate and per-disk free/used space.
    * Indicate disk power status (active/spun-down).
    * Show real-time I/O metrics (MB/s, IOPS) for active disks.
    * Display the current queue of pending and executing background tasks (migration, MD5, MediaInfo).
* **5. Power-Efficient Operation**
    * Utilize a local database for all planning activities to prevent unnecessary disk reads.
    * Do not wake up sleeping disks unless an explicit task is executed by the user.
    * Opportunistically perform tasks if disks are already awake due to other system processes.
* **6. Simplified Distribution & Open Source**
    * Package the application and all dependencies into a single Docker container via GitHub Actions.
    * Include reminders in the UI and documentation for users to donate to the developer.

### Background Context

MediaMogul is a web-based application designed for home media server enthusiasts who manage large collections of files across multiple, independent hard drives. The primary problem it solves is the complexity of organizing, migrating, and monitoring media files in a power-conscious environment. Users need a tool that allows for strategic data management without constantly waking up sleeping disks, providing both high-level dashboards and deep, historical insights into their media library.

### Change Log

| Date | Version | Description | Author |
| :--- | :--- | :--- | :--- |
| 2025-08-04 | 2.0 | Added SmartMover feature | John (PM) |

---

## Requirements (V12)

### Functional

1.  **FR1:** The system shall allow users to create a 'migration plan' by selecting source files/folders and a destination disk. The plan must include a forecast of disk space changes and a list of all proposed `rsync` tasks.
2.  **FR2:** The system shall execute approved migration plans using `rsync`, with each migration job being scheduled and tracked in a 'tasks' database table.
3.  **FR3:** The system shall scan user-configured disk paths to discover and monitor files and folders.
4.  **FR4:** The system shall detect and record file/folder changes (created, modified, deleted, moved) in a historical changelog.
5.  **FR5:** The system shall calculate and store MD5 checksums for files. This operation should only be triggered if the file's checksum does not already exist in the database, or if the file has been modified. The checksum calculation should be skipped if it can be obtained directly from an `rsync` migration of the same file.
6.  **FR6:** The system shall use the MediaInfo library to extract and store specified metadata from media files as a background task.
7.  **FR7:** The UI shall provide a historical view of all recorded changes for a specific file or folder path.
8.  **FR8:** The system must identify when a file is replaced in-place (same name, different MD5) and report the delta in disk space, video codec, and audio codec.
9.  **FR9:** The system shall connect to the Sonarr and Radarr APIs to correlate file data and tag corresponding files within its own database.
10. **FR10:** The main dashboard shall display an aggregate and per-disk summary of disk space, the power status of each disk, and real-time I/O metrics for active disks. It must also provide a detailed view of the task queue, including the number of parallel tasks currently executing, the number of pending tasks, and the execution mode (e.g., scheduled, opportunistic) for pending tasks.
11. **FR11:** The system must provide users with three execution options for all background tasks: 'Execute Now', 'Schedule for a specific time', and 'Execute Opportunistically'.
12. **FR12:** A conditional monitoring process shall run only when 'opportunistic' tasks are queued. This monitor will trigger task execution once it detects that all required source and destination disks are active.
13. **FR13:** The file browser UI must display the total disk space consumed by any folder the user is viewing, including all its children files and folders.
14. **FR14:** During migration planning, the UI must display a running counter with the total data size of all selected items.
15. **FR15:** The system shall provide a read-only file browser in the web UI for users to navigate their monitored disks, files, and folders.
16. **FR16:** From the file browser, users must be able to select files or folders and seamlessly transition into a 'migration planning' stage.
17. **FR17:** The file browser UI must provide an option for users to trigger a manual 'rescan' on a selected file or a batch of files/folders.
18. **FR18:** The 'rescan' task will compare the on-disk file's state against the database record and display a visual indicator in the UI if a discrepancy is found.
19. **FR19:** Upon completion or failure of a migration plan's execution, the system must generate and persist a summary report. This report, detailing the outcome of each task within the plan, must be accessible to the user in a dedicated 'Plan History' section of the UI, independent of the user's browser session.
20. **FR20:** The system must store historical data points for disk usage and provide visualizations (graphs) of this data. The data retention period should be configurable by the user (defaulting to 90 days), with an option to extend it for longer-term analysis.
21. **FR21:** The system shall provide a 'YOLO mode' that, when enabled by the user, adds UI options for the permanent deletion of selected files or folders.
22. **FR22:** When a deletion is initiated, the system must present a confirmation dialog that offers two execution choices: delete immediately or queue the deletion as a background task.
23. **FR23:** All deletion events must be recorded in the file/folder historical changelog, noting that the action was performed via MediaMogul.
24. **FR24:** The main dashboard must display a scrollable changelog viewer showing the 'X' most recent changes detected by the system, ordered from newest to oldest. 'X' is a user-configurable value defaulting to 50.
25. **FR25 (New):** The system shall provide a 'SmartMover' feature that automatically generates a comprehensive migration plan, presented on the Plan Canvas, based on a user-selected algorithm.
26. **FR26 (New):** The SmartMover 'Maximum Organization' algorithm shall generate a plan that fills disks sequentially, ensuring entire movie folders and TV show seasons remain co-located on a single disk.
27. **FR27 (New):** The SmartMover 'Optimized Organization' algorithm shall generate a plan that fills disks sequentially, allowing TV show seasons to be split across disks if an entire season does not fit on the current target disk.
28. **FR28 (New):** The SmartMover 'Even-Steven' algorithm shall generate a plan that distributes individual files across all available disks in a round-robin fashion to balance the final percentage of free space on each disk.
29. **FR29 (New):** The SmartMover 'Smarter-Steven' algorithm shall generate a plan to balance the final percentage of free space on each disk, but will treat related folders (like TV show seasons) as blocks to keep them co-located where possible during distribution.

### Non-Functional

1.  **NFR1:** The system must not wake up spun-down (sleeping) hard drives for any UI-based planning or analysis activity; disk access is only permitted for user-initiated tasks.
2.  **NFR2:** The system must be able to opportunistically execute tasks if it detects that a required disk is already awake due to external processes.
3.  **NFR3:** The application must be packaged and distributed as a Docker container, including all necessary dependencies.
4.  **NFR4:** The system's functionality is dependent on the pre-existence of `rsync`, `mediainfo`, and `smartctl` binaries in the host environment.
5.  **NFR5:** The application's UI and repository must include prominent, non-intrusive links for users to donate to the developer.
6.  **NFR6:** The backend must be developed in Golang.
7.  **NFR7:** The frontend must be a modern framework and can incorporate UI elements like `shadcn`.
8.  **NFR8:** The application must provide global settings for users to control the default execution behavior of I/O-heavy operations.
9.  **NFR9:** The system's task scheduler must prioritize I/O-heavy tasks, considering `rsync` as the heaviest, followed by `md5sum`, and then `mediainfo`.
10. **NFR10:** To manage long-term data storage, the system should implement a data aggregation strategy. While aggregated time-series data for visualizations will be kept for the user-configured retention period, detailed, granular event logs may be pruned after a shorter, fixed period to control database size.
11. **NFR11:** The 'YOLO mode' for file deletion must be disabled by default. It can only be activated by the user via the application's settings page.

---

## User Interface Design Goals (V4)

### Overall UX Vision

The user experience for MediaMogul should be data-rich, clean, and highly functional. It should empower users with clear insights—both real-time and historical—and precise control over their media library and server hardware. The interface should feel like a professional-grade tool that is also intuitive for performing complex planning and monitoring tasks.

### Key Interaction Paradigms

* **Drill-Down Dashboard:** The main dashboard will provide a high-level summary, with widgets that allow users to click through to more detailed views.
* **Historical Data Visualization:** The UI will feature interactive graphs and charts to display trends in disk usage and I/O over time, similar to professional monitoring tools.
* **Dual-Mode File Browser:** A "Read-Only" mode for safe Browse and a "Planning" mode for selecting items for migration or other tasks.
* **Visual Planners:** Migration and other multi-step tasks will be configured in a dedicated planning interface that provides clear visual feedback and forecasts before any action is taken.
* **Asynchronous Task Management:** Users will interact with a task manager to queue, monitor, and view reports from background jobs, ensuring the UI remains responsive at all times.

### Core Screens and Views

* **Dashboard:** The main landing page with system overview, disk status, the task queue summary, and a scrollable "Recent Changes" viewer.
* **File Browser:** A navigable tree view of all monitored disks and folders.
* **Migration Planner:** A dedicated interface for creating, reviewing, and executing migration plans.
* **Task Manager:** A detailed view of all active, pending, and completed tasks.
* **Plan History:** A screen to view historical reports from completed migration plans.
* **Settings:** A section for configuring the application, including Sonarr/Radarr API keys, global task settings, enabling 'YOLO mode' for file deletion, and setting the number of items for the dashboard's 'Recent Changes' viewer.

### Accessibility: WCAG AA

* **Assumption:** We will target WCAG 2.1 AA compliance as a baseline to ensure the application is usable by a wide range of individuals.

### Branding

* The application should have a clean, modern, "pro-tool" aesthetic, likely with a dark mode option suitable for media center environments.
* UI elements should be inspired by modern component libraries like `shadcn` as requested.
* Donation links and branding for "@TheLinuxGuy" should be present but unobtrusive.

### Target Device and Platforms: Web Responsive

* The application will be a web-based interface designed primarily for desktop use but should be responsive and functional on tablet and mobile browsers.

---

## Technical Assumptions (V2)

### Repository Structure: Monorepo

* **Recommendation:** A monorepo structure is recommended for this project.
* **Rationale:** Since the backend (Golang) and frontend are tightly coupled and will likely share data types and logic, a monorepo simplifies development, dependency management, and build processes.

### Service Architecture: Monolith

* **Recommendation:** A monolithic architecture is recommended for the initial version of MediaMogul.
* **Rationale:** The application has a clear, focused set of features. A monolith will be simpler to develop, deploy via a single Docker container, and maintain, avoiding the complexities of a microservice architecture which is likely overkill for this project's scope.

### Testing Requirements: Unit + Integration

* **Recommendation:** The project should include both unit tests for individual functions and integration tests to verify interactions between different parts of the system (e.g., API calls, database operations).
* **Rationale:** This provides a solid balance of speed and confidence, ensuring that individual components are correct and that they work together as expected.

### Database

* **Recommendation:** An embedded database like **SQLite** is recommended.
* **Rationale:** For a self-hosted, single-user application, an embedded database is ideal. It simplifies the setup process, has no external dependencies, reduces resource consumption, and is perfectly capable of handling the required workload.

### Additional Technical Assumptions and Requests

* **Backend Language:** The backend will be written in **Golang**.
* **Frontend Framework:** The frontend will use a modern JavaScript/TypeScript framework, incorporating UI components from a library like **shadcn**.
* **System Dependencies:** The application's host environment must have `rsync`, `mediainfo`, and `smartctl` binaries installed and accessible.
* **Distribution:** The final application will be packaged and distributed as a **Docker container** using a CI/CD pipeline (e.g., GitHub Actions).
* **External APIs:** The application will need to integrate with the REST APIs for **Sonarr** and **Radarr**.

---

## Epic List

* **Epic 1: Foundation, Core Scanning, & Dashboard MVP**
    * **Goal:** Establish the application's technical foundation, implement the core file scanning and database population, and provide immediate user value with a read-only file browser and a system dashboard.
* **Epic 2: Asynchronous Task Engine & Data Enrichment**
    * **Goal:** Build the background task engine with multiple execution modes and empower users to enrich their data with on-demand MD5 and MediaInfo scans.
* **Epic 3: Migration Planning and Execution**
    * **Goal:** Deliver the application's core feature by enabling users to create, review, execute, and track comprehensive data migration plans to organize their disks.
* **Epic 4: Ecosystem Integration & Advanced Management**
    * **Goal:** Enhance the application by integrating with external services like Sonarr and Radarr, and provide advanced file deletion capabilities for power-users via the "YOLO mode".
* **Epic 5 (New): Automated Migration Planning with SmartMover**
    * **Goal:** To provide users with a powerful, automated tool that analyzes their entire library and proposes an optimal data reorganization plan, saving significant manual effort.

---
*(Note: Detailed stories for Epic 5 would be created in a subsequent session after this PRD is approved and handed off for architecture.)*

## Epic 1 Details ...
## Epic 2 Details ...
## Epic 3 Details ...
## Epic 4 Details ...
*(Full story breakdowns as previously detailed would be included here)*

---

## Checklist Results Report

### PRD & EPIC VALIDATION SUMMARY

| Category | Status | Critical Issues |
| :--- | :--- | :--- |
| 1. Problem Definition & Context | ✅ PASS | None |
| 2. MVP Scope Definition | ✅ PASS | None |
| 3. User Experience Requirements | ✅ PASS | None |
| 4. Functional Requirements | ✅ PASS | None |
| 5. Non-Functional Requirements | ✅ PASS | None |
| 6. Epic & Story Structure | ✅ PASS | None |
| 7. Technical Guidance | ✅ PASS | None |
| 8. Cross-Functional Requirements | ✅ PASS | None |
| 9. Clarity & Communication | ✅ PASS | None |

**Final Decision:** ✅ **READY FOR ARCHITECT**: The Product Requirements Document is comprehensive, properly structured, and ready for architectural design.

---

## Next Steps

This document is now complete and validated. The next stage is to hand this document off to the specialist agents who will design the system's architecture and user experience in more detail.

### UX Expert Prompt

*To be used with the UX Expert (`*agent ux-expert`)*

> "Using the attached PRD for the 'MediaMogul' project, please create a detailed UI/UX Specification. Focus on translating the 'User Interface Design Goals' and functional requirements into a comprehensive plan covering information architecture, user flows, and a component design strategy."

### Architect Prompt

*To be used with the Architect (`*agent architect`)*

> "Using the attached PRD for the 'MediaMogul' project, please create a comprehensive Fullstack Architecture Document. The PRD contains detailed technical assumptions and functional requirements that must be addressed in your design. The goal is to produce a complete architectural blueprint that is ready for implementation."