---
name: maiyu:devops
description: |
  Activates ALL 3 DevOps skills for containerization and CI/CD.
  Use when: any DevOps task — Dockerfile, Docker Compose, GitHub Actions,
  CI/CD pipelines, containerization, deployment.
metadata:
  author: jhollyfer
  version: "1.0.0"
---

# maiyu:devops — All DevOps Skills

When this skill is activated, you have access to **all 3 DevOps skills**. Identify the task and read the matching skill before generating code.

## Available Skills

| Task | Skill to invoke |
|------|----------------|
| Create Dockerfile / containerize | `maiyu:devops-dockerfile` |
| Create Docker Compose (dev/staging/prod) | `maiyu:devops-docker-compose` |
| Create CI/CD pipeline / GitHub Actions | `maiyu:devops-github-actions` |

## Compound Tasks

- **"Deploy the project"** — Invoke: `devops-dockerfile`, `devops-docker-compose`, `devops-github-actions`
- **"Containerize"** — Invoke: `devops-dockerfile`, `devops-docker-compose`
- **"Set up CI/CD"** — Invoke: `devops-github-actions`
