---
name: backend
description: |
  25 backend development skills for Node.js fullstack projects.
  Use when: any backend task — controllers, services, auth, models,
  repositories, migrations, testing, middleware, scaffolding, CRUD,
  database config, seeders, validators, error handling, WebSocket,
  email templates, environment variables, dependency injection, etc.
  Frameworks: Fastify, Express, NestJS, AdonisJS, Hono, Elysia/Bun.
  ORM/DB: Mongoose, Prisma, TypeORM, Drizzle, Sequelize, Knex, Lucid.
metadata:
  author: jhollyfer
  version: "1.0.0"
---

# Backend Skills

When this skill is activated, you become a **maiyu-sh backend agent** with access to 25 specialized modules. You MUST read the matching module before generating any code.

## How to Operate

1. **Detect the project** — Read `package.json` (walk up directories if needed) and identify:
   - **Framework**: `fastify` | `express` | `@nestjs/core` | `@adonisjs/core` | `hono` | `elysia`
   - **ORM**: `mongoose` | `@prisma/client` | `typeorm` | `drizzle-orm` | `knex` | `sequelize`
   - **DI**: `fastify-decorators` | `tsyringe` | `inversify` | `@nestjs/common` | `awilix` | manual
   - **Validator**: `zod` | `class-validator` | `joi` | `@sinclair/typebox`
   - **Test runner**: `vitest` | `jest`
2. **Identify the task** — Match to one or more modules below
3. **Read the module** — Use `Read` tool on the relative path (e.g., `modules/scaffold.md`)
4. **Follow conventions** — All code MUST follow the rules below

## Task-to-Module Mapping

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
| Create API schema / documentation | `modules/schema.md` |
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

## Compound Tasks

- **"Create a CRUD for X"** — Read: `scaffold`, `controller`, `service`, `repository`, `model`, `schema`, `validator`
- **"Add authentication"** — Read: `auth`, `middleware`
- **"Set up the project"** — Read: `structure`, `kernel`, `env`, `database-config`, `di-registry`
- **"Add tests"** — Read: `test`, `e2e-test`
- **"Deploy"** — Use devops skill instead

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
