---
name: maiyu-sh
description: |
  59 fullstack development skills for Node.js projects.
  Use when: any backend, frontend, or DevOps task — controllers, services,
  auth, models, repositories, migrations, testing, middleware, scaffolding,
  CRUD pages, forms, data tables, kanban, calendar, file upload, filters,
  rich editor, permissions, RBAC, stores, routes, SEO, error screens,
  Dockerfile, Docker Compose, GitHub Actions, CI/CD pipelines, and more.
  Backend: Fastify, Express, NestJS, AdonisJS, Hono, Elysia/Bun.
  Frontend: Next.js, TanStack Start, React (Vite), Remix, Vue.
  DevOps: Docker, Docker Compose, GitHub Actions.
  ORM/DB: Mongoose, Prisma, TypeORM, Drizzle, Sequelize, Knex, Lucid.
  UI: shadcn, Radix, Tailwind, TanStack Table, TanStack Form, TanStack Query.
  State: Zustand, TanStack Query.
metadata:
  author: jhollyfer
  version: "2.0.0"
---

# maiyu-sh Skills

When this skill is activated, you become a **maiyu-sh fullstack agent** with access to 59 specialized modules. You MUST read the matching module before generating any code.

## How to Operate

1. **Detect the project** — Read `package.json` (walk up directories if needed) and identify:
   - **Framework**: `fastify` | `express` | `@nestjs/core` | `@adonisjs/core` | `hono` | `elysia` | `next` | `@tanstack/react-start` | `react` (Vite) | `@remix-run/react` | `vue`
   - **ORM**: `mongoose` | `@prisma/client` | `typeorm` | `drizzle-orm` | `knex` | `sequelize`
   - **DI**: `fastify-decorators` | `tsyringe` | `inversify` | `@nestjs/common` | `awilix` | manual
   - **Validator**: `zod` | `class-validator` | `joi` | `@sinclair/typebox`
   - **Form lib**: `@tanstack/react-form` | `react-hook-form` | `formik`
   - **UI**: `@radix-ui/*` | `shadcn` | `tailwindcss`
   - **Table**: `@tanstack/react-table`
   - **State**: `zustand` | `@tanstack/react-query`
   - **Test runner**: `vitest` | `jest`
   - **Package manager**: `npm` | `pnpm` | `yarn`
2. **Identify the task** — Match to one or more modules below
3. **Read the module** — Use `Read` tool on the relative path (e.g., `modules/scaffold.md`)
4. **Follow conventions** — All code MUST follow the rules below

---

## Backend Tasks

| Task | Module to read |
|------|---------------|
| Scaffold CRUD / generate all layers for an entity | `modules/scaffold.md` + `references/crud-actions.md` |
| Create controller / route handler / endpoint | `modules/controller.md` |
| Create service / business logic layer | `modules/service.md` |
| Create use case | `modules/use-case.md` |
| Create repository (contract + implementation) | `modules/repository.md` + `references/repository-templates.md` |
| Create model / entity | `modules/model.md` + `references/mongoose-patterns.md` |
| Add authentication (JWT, OAuth, sessions) | `modules/auth.md` |
| Create middleware / hooks | `modules/middleware.md` |
| Add data validation | `modules/validator.md` |
| Create API schema / documentation | `modules/api-schema.md` |
| Create database migration | `modules/migration.md` |
| Create database seeder | `modules/seeder.md` |
| Configure database connection | `modules/database-config.md` |
| Configure environment variables | `modules/env.md` |
| Configure dependency injection | `modules/di-registry.md` |
| Configure server bootstrap / kernel | `modules/kernel.md` |
| Define project folder structure | `modules/structure.md` |
| Add error handling / exceptions | `modules/error-handling.md` |
| Add unit or E2E tests | `modules/test.md` + `references/test-patterns.md` |
| Add E2E test setup and helpers | `modules/e2e-test.md` |
| Add email service with templates | `modules/email-template.md` |
| Add WebSocket / real-time | `modules/realtime.md` |
| Add sandboxed script execution | `modules/sandbox.md` |
| Add clone, import, or export endpoints | `modules/clone-import-export.md` |
| Set up fullstack monorepo | `modules/fullstack-monorepo.md` |

## Frontend Tasks

| Task | Module to read |
|------|---------------|
| Create a form / edit form / field component | `modules/form.md` |
| Create a dynamic form from definitions | `modules/dynamic-form.md` |
| Create a Zod validation schema | `modules/zod-schema.md` |
| Create a React component | `modules/component.md` |
| Create a complete CRUD page | `modules/crud-page.md` |
| Create a data table | `modules/data-table.md` |
| Advanced data table with virtualization | `modules/data-table-patterns.md` |
| Create a date picker (single/range) | `modules/datepicker.md` |
| Create error, loading, empty state screens | `modules/error-screens.md` |
| Add input masks | `modules/field-mask.md` |
| Add file upload component | `modules/file-upload.md` |
| Create URL-based filter system | `modules/filter.md` |
| Create TanStack Query hooks | `modules/hook-query.md` |
| TanStack Query patterns and conventions | `modules/query-patterns.md` |
| Create kanban board with drag-and-drop | `modules/kanban.md` |
| Create a calendar view (month/week/agenda) | `modules/calendar-view.md` |
| Create a Next.js App Router page | `modules/next-page.md` |
| Create page shell layout (Header/Content/Footer) | `modules/page-shell.md` |
| Add permission system | `modules/permission.md` |
| Add role-based access control | `modules/rbac.md` |
| Create a rich text editor (TipTap) | `modules/rich-editor.md` |
| Define file-based routes | `modules/route.md` |
| Configure SEO | `modules/seo.md` |
| Create system settings page | `modules/settings-page.md` |
| Create Zustand store | `modules/store.md` |
| Create auth store (Zustand) | `modules/auth-store.md` |
| Create API client / service layer | `modules/api-service.md` |
| Create tree/hierarchical component | `modules/tree-component.md` |
| Create tree navigation | `modules/tree-navigation.md` |
| Create UI primitives (shadcn/Radix) | `modules/ui.md` |
| Create view type (list/card/kanban/calendar) | `modules/view.md` |

## DevOps Tasks

| Task | Module to read |
|------|---------------|
| Create Dockerfile / containerize | `modules/dockerfile.md` |
| Create Docker Compose (dev/staging/prod) | `modules/docker-compose.md` |
| Create CI/CD pipeline / GitHub Actions | `modules/github-actions.md` |

---

## Compound Tasks

- **"Create a CRUD for X" (backend)** — Read: `scaffold`, `controller`, `service`, `repository`, `model`, `api-schema`, `validator`
- **"Create a CRUD for X" (frontend)** — Read: `crud-page`, `form`, `data-table`, `hook-query`
- **"Create a new page"** — Read: `next-page` or `route`, `page-shell`, `component`
- **"Create a form"** — Read: `form`, `zod-schema`, `field-mask`, `datepicker`
- **"Add authentication"** — Read: `auth`, `middleware`, `auth-store`, `permission`, `rbac`
- **"Add a filter"** — Read: `filter`, `data-table`
- **"Set up the project"** — Read: `structure`, `kernel`, `env`, `database-config`, `di-registry`
- **"Add tests"** — Read: `test`, `e2e-test`
- **"Deploy the project"** — Read: `dockerfile`, `docker-compose`, `github-actions`
- **"Containerize"** — Read: `dockerfile`, `docker-compose`
- **"Set up CI/CD"** — Read: `github-actions`

## Conventions

All generated code MUST follow these rules:

- **Zero `any`** — use concrete types, `unknown`, generics, `Record<string, unknown>`
- **Zero ternaries** — use if/else, early return, const mapper
- **Zero `as TYPE`** — use type guards, generics (except `as const`)
- **Explicit return types** on all functions and components
- **Multiple conditions** — const mapper (object lookup instead of switch/if-else chains)
- **Named exports only** — no default exports (except fastify-decorators)
- **Soft deletes by default** — `trashed: boolean`, `trashedAt: Date | null`
- **Either pattern** for error handling — left = error, right = success
- **Compound components** with `data-slot` attributes (frontend)
- **No prop drilling** — use context/hooks (frontend)
