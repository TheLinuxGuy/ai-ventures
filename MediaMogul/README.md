# MediaMogul

Can we build a media file server file manager which allows users to quickly and easily view
- hard drive stats (free space/used)
- easy migrate data between hard drives and mount points using rsync via web UI.
- visualize media usage on the server across physical disks and partitions.
- visualize data from other systems (Sonarr, Radarr)
- keep history tracker of folder and files created, updated, deleted, moved.

## Development setup

- Ubuntu LXC container intended to be used for dev and local testing.
  - We need to have a local system where I can easily add virtual disks so our program can move data around between A and B disks.

## AI details

### Agentic Framework
- [BMAD-METHOD](https://github.com/bmadcode/BMAD-METHOD)

### Models 
- gemini-2.5 Pro was used to create the plan.
    *   Interface: Web UI using `gems` for persona for all `docs/`
- claude-sonnet4 was used via vscode copilot for codebase generation.

### Software
- VS Code
- Gemini CLI

## Local development setup

```bash
# Golang (ensure version 1.22 or higher)
go version

# Node.js (ensure version 20 or higher) and pnpm
node -v
pnpm -v

# Docker and Docker Compose
docker --version
docker compose version

# 1. Install all Node.js dependencies from the root directory
pnpm install

# 2. Download all Golang dependencies
cd apps/backend
go mod tidy
cd ../..

# 3. Create local environment files from the examples
cp .env.example apps/backend/.env
cp .env.local.example apps/frontend/.env.local

# 4. Build and start the application containers
docker compose up --build -d
```
### Development commands

```bash
# 1. Install all Node.js dependencies from the root directory
pnpm install

# 2. Download all Golang dependencies
cd apps/backend
go mod tidy
cd ../..

# 3. Create local environment files from the examples
cp .env.example apps/backend/.env
cp .env.local.example apps/frontend/.env.local

# 4. Build and start the application containers
docker compose up --build -d
```

### Required .env variables

```bash
# File: apps/backend/.env
# --- Backend Configuration ---
DATABASE_URL="file:mediamogul.db"
JWT_SECRET="a-very-strong-and-secret-key-for-jwt"
SONARR_URL="http://your-sonarr-host:8989"
SONARR_API_KEY=""
RADARR_URL="http://your-radarr-host:7878"
RADARR_API_KEY=""

# File: apps/frontend/.env.local
# --- Frontend Configuration ---
NEXT_PUBLIC_API_URL="http://localhost:8080/api/v1"
```