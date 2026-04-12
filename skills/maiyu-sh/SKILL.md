---
name: maiyu-sh
description: |
  Master skill that activates the full maiyu-sh development toolkit.
  Use when: user invokes /maiyu-sh without specifying a sub-skill,
  or asks to "use maiyu", "use all skills", "activate maiyu-sh".
  This skill makes the agent aware of all 59+ available skills and
  instructs it to automatically detect the project stack and apply
  the relevant skills as needed.
metadata:
  author: jhollyfer
  version: "1.0.0"
---

# maiyu-sh — Full Development Toolkit

When this skill is activated, you become a **maiyu-sh powered agent**. You have access to 59+ specialized fullstack development skills and MUST use them proactively throughout the conversation.

## How to Operate

1. **Detect the project** — Read `package.json` (walk up directories if needed) and identify:
   - Framework: Fastify, Express, NestJS, AdonisJS, Hono, Elysia, Next.js, Remix, TanStack Start, Vue
   - ORM/DB: Mongoose, Prisma, TypeORM, Drizzle, Sequelize, Knex, Lucid
   - UI: shadcn, Radix, Tailwind, TanStack Table, TanStack Form, React Hook Form
   - State: Zustand, TanStack Query
   - DI: fastify-decorators, tsyringe, inversify, awilix, NestJS

2. **Auto-invoke skills** — For every task the user gives you, invoke the matching `maiyu-sh:<skill>` skill BEFORE writing code. Multiple skills can apply to a single task.

3. **Follow conventions** — All code you generate MUST follow these rules:
   - Zero `any` — use concrete types, `unknown`, generics, `Record<string, unknown>`
   - Zero ternaries — use if/else, early return, const mapper
   - Zero `as TYPE` — use type guards, generics (except `as const`)
   - Explicit return types on all functions and components
   - Multiple conditions → const mapper (object lookup instead of switch/if-else)
   - Named exports only (no default exports, except fastify-decorators)
   - Compound components with `data-slot` attributes
   - No prop drilling — use context/hooks
   - Soft deletes by default (`trashed: boolean`, `trashedAt: Date | null`)
   - Either pattern for error handling (left = error, right = success)

---

## Available Skills

### Backend (24)

| Skill | When to use |
|-------|-------------|
| `maiyu-sh:backend-auth` | Authentication modules (JWT, OAuth2, sessions, magic links, password reset) |
| `maiyu-sh:backend-clone-import-export` | Clone, import, or export endpoints |
| `maiyu-sh:backend-controller` | HTTP controllers, routes, endpoints, handlers |
| `maiyu-sh:backend-database-config` | Database connection setup |
| `maiyu-sh:backend-di-registry` | Dependency injection registration |
| `maiyu-sh:backend-e2e-test` | E2E test setup and helpers |
| `maiyu-sh:backend-email-template` | Email service with EJS templates |
| `maiyu-sh:backend-env` | Environment variable validation |
| `maiyu-sh:backend-error-handling` | Error handling systems and exceptions |
| `maiyu-sh:backend-kernel` | Server bootstrap/kernel |
| `maiyu-sh:backend-middleware` | Middlewares and hooks |
| `maiyu-sh:backend-migration` | Database migrations |
| `maiyu-sh:backend-model` | Data models/entities |
| `maiyu-sh:backend-realtime` | WebSocket / real-time communication |
| `maiyu-sh:backend-repository` | Repository pattern (contract + implementation + in-memory) |
| `maiyu-sh:backend-sandbox` | Sandboxed script execution |
| `maiyu-sh:backend-scaffold` | Full CRUD scaffolding |
| `maiyu-sh:backend-schema` | API schemas and documentation |
| `maiyu-sh:backend-seeder` | Database seeders |
| `maiyu-sh:backend-service` | Service pattern (contract + implementation) |
| `maiyu-sh:backend-structure` | Project folder structure |
| `maiyu-sh:backend-test` | Unit and E2E tests |
| `maiyu-sh:backend-use-case` | Business logic / use cases |
| `maiyu-sh:backend-validator` | Data validation (Zod, class-validator, Joi, TypeBox) |

### Frontend (31)

| Skill | When to use |
|-------|-------------|
| `maiyu-sh:frontend-api-service` | API client layer |
| `maiyu-sh:frontend-auth-store` | Authentication state (Zustand) |
| `maiyu-sh:frontend-calendar-view` | Calendar components (month, week, agenda) |
| `maiyu-sh:frontend-component` | React components |
| `maiyu-sh:frontend-crud-page` | Complete CRUD pages |
| `maiyu-sh:frontend-data-table` | Data tables (TanStack Table) |
| `maiyu-sh:frontend-data-table-patterns` | Generic DataTable with virtualization |
| `maiyu-sh:frontend-datepicker` | Date picker (single/range) |
| `maiyu-sh:frontend-dynamic-form` | Dynamic forms from definitions |
| `maiyu-sh:frontend-error-screens` | Error, loading, empty state screens |
| `maiyu-sh:frontend-field-mask` | Input masks |
| `maiyu-sh:frontend-file-upload` | File upload (compound components) |
| `maiyu-sh:frontend-filter` | URL-based filter systems |
| `maiyu-sh:frontend-form` | Forms and field components |
| `maiyu-sh:frontend-hook-query` | TanStack Query hooks (queries + mutations) |
| `maiyu-sh:frontend-kanban` | Kanban board with drag-and-drop |
| `maiyu-sh:frontend-next-page` | Next.js App Router pages |
| `maiyu-sh:frontend-page-shell` | Layout shell (Header/Content/Footer) |
| `maiyu-sh:frontend-permission` | Permission systems |
| `maiyu-sh:frontend-query-patterns` | TanStack Query patterns |
| `maiyu-sh:frontend-rbac` | Role-based access control |
| `maiyu-sh:frontend-rich-editor` | Rich text editor (TipTap) |
| `maiyu-sh:frontend-route` | File-based route definitions |
| `maiyu-sh:frontend-schema` | Zod validation schemas |
| `maiyu-sh:frontend-seo` | SEO configuration |
| `maiyu-sh:frontend-settings-page` | System settings pages |
| `maiyu-sh:frontend-store` | Zustand stores |
| `maiyu-sh:frontend-tree-component` | Tree/hierarchical components |
| `maiyu-sh:frontend-tree-navigation` | Hierarchical navigation |
| `maiyu-sh:frontend-ui` | UI primitives (shadcn/Radix) |
| `maiyu-sh:frontend-view` | View types (list, card, kanban, calendar) |

### DevOps (3)

| Skill | When to use |
|-------|-------------|
| `maiyu-sh:devops-docker-compose` | Docker Compose for different environments |
| `maiyu-sh:devops-dockerfile` | Dockerfiles for Node.js projects |
| `maiyu-sh:devops-github-actions` | CI/CD workflows with GitHub Actions |

### Fullstack (1)

| Skill | When to use |
|-------|-------------|
| `maiyu-sh:fullstack-monorepo` | Fullstack monorepo setup |

---

## Task-to-Skill Mapping

When the user asks you to do something, match the task to skills:

- **"Create a CRUD for X"** → `backend-scaffold`, `backend-controller`, `backend-service`, `backend-repository`, `backend-model`, `backend-schema`, `backend-validator`, `frontend-crud-page`, `frontend-form`, `frontend-data-table`, `frontend-hook-query`
- **"Add authentication"** → `backend-auth`, `backend-middleware`, `frontend-auth-store`, `frontend-permission`, `frontend-rbac`
- **"Create a new page"** → `frontend-next-page` or `frontend-route`, `frontend-page-shell`, `frontend-component`
- **"Create a form"** → `frontend-form`, `frontend-schema`, `frontend-field-mask`, `frontend-datepicker`
- **"Set up the project"** → `backend-structure`, `backend-kernel`, `backend-env`, `backend-database-config`, `backend-di-registry`, `devops-dockerfile`, `devops-docker-compose`
- **"Add tests"** → `backend-test`, `backend-e2e-test`
- **"Add email"** → `backend-email-template`
- **"Add real-time"** → `backend-realtime`
- **"Deploy"** → `devops-dockerfile`, `devops-docker-compose`, `devops-github-actions`

Always invoke the skill via the Skill tool before generating code. Never guess — load the skill and follow its templates.
