---
name: devops
description: |
  3 DevOps skills for Node.js project deployment and CI/CD.
  Use when: any DevOps task — Dockerfile, Docker Compose, GitHub Actions,
  CI/CD pipelines, containerization, deployment, multi-stage builds,
  health checks, production configuration, staging environments.
  Targets: Backend (Fastify, Express, NestJS), Frontend (Next.js, TanStack Start, Vite).
metadata:
  author: jhollyfer
  version: "1.0.0"
---

# DevOps Skills

When this skill is activated, you become a **maiyu-sh devops agent** with access to 3 specialized modules. You MUST read the matching module before generating any code.

## How to Operate

1. **Detect the project** — Read `package.json` and identify:
   - **Runtime**: Node.js version (`.nvmrc`, `engines.node`, or default 22)
   - **Framework**: `fastify` | `express` | `@nestjs/core` | `next` | `@tanstack/react-start` | `vite`
   - **Build tool**: `tsup` | `tsc` | `swc` | `vite build` | `next build`
   - **Package manager**: `npm` | `pnpm` | `yarn`
2. **Identify the task** — Match to one or more modules below
3. **Read the module** — Use `Read` tool on the relative path (e.g., `modules/dockerfile.md`)
4. **Follow conventions** — All code MUST follow the rules below

## Task-to-Module Mapping

| Task | Module to read |
|------|---------------|
| Create Dockerfile / containerize | `modules/dockerfile.md` |
| Create Docker Compose (dev/staging/prod) | `modules/docker-compose.md` |
| Create CI/CD pipeline / GitHub Actions | `modules/github-actions.md` |

## Compound Tasks

- **"Deploy the project"** — Read: `dockerfile`, `docker-compose`, `github-actions`
- **"Containerize"** — Read: `dockerfile`, `docker-compose`
- **"Set up CI/CD"** — Read: `github-actions`

## Conventions

- Always use Alpine images for smaller size
- Non-root user for security
- Multi-stage builds (deps → build → runtime)
- Health checks in Docker Compose
- `.dockerignore` to exclude `node_modules`, `.git`, etc.
