---
name: maiyu:backend
description: |
  Activates ALL 24 backend skills for Node.js projects.
  Use when: any backend task — controllers, services, repositories, models,
  auth, middleware, migrations, testing, scaffolding, seeders, validators,
  error handling, WebSocket, email templates, environment variables,
  dependency injection, monorepo setup.
  Frameworks: Fastify, Express, NestJS, AdonisJS, Hono, Elysia/Bun.
  ORM/DB: Mongoose, Prisma, TypeORM, Drizzle, Sequelize, Knex, Lucid.
metadata:
  author: jhollyfer
  version: "1.0.0"
---

# maiyu:backend — All Backend Skills

When this skill is activated, you have access to **all 24 backend skills**. Identify the task and read the matching skill before generating code.

## How to Operate

1. **Detect the project** — Read `package.json` (walk up directories if needed) and identify:
   - **Framework**: `fastify` | `express` | `@nestjs/core` | `@adonisjs/core` | `hono` | `elysia`
   - **ORM**: `mongoose` | `@prisma/client` | `typeorm` | `drizzle-orm` | `knex` | `sequelize`
   - **DI**: `fastify-decorators` | `tsyringe` | `inversify` | `@nestjs/common` | `awilix` | manual
   - **Validator**: `zod` | `class-validator` | `joi` | `@sinclair/typebox`
   - **Test runner**: `vitest` | `jest`
   - **Package manager**: `npm` | `pnpm` | `yarn`
2. **Identify the task** — Match to the skill below
3. **Read the skill** — Use `Skill` tool to invoke the specific `maiyu:backend-*` skill
4. **Follow conventions** — All code MUST follow the rules below

## Available Skills

| Task | Skill to invoke |
|------|----------------|
| Scaffold CRUD / generate all layers | `maiyu:backend-scaffold` |
| Create controller / route handler | `maiyu:backend-controller` |
| Create service / business logic | `maiyu:backend-service` |
| Create use case | `maiyu:backend-use-case` |
| Create repository (contract + impl) | `maiyu:backend-repository` |
| Create model / entity | `maiyu:backend-model` |
| Add authentication (JWT, OAuth) | `maiyu:backend-auth` |
| Create middleware / hooks | `maiyu:backend-middleware` |
| Add data validation | `maiyu:backend-validator` |
| Create API schema / docs | `maiyu:backend-schema` |
| Create database migration | `maiyu:backend-migration` |
| Create database seeder | `maiyu:backend-seeder` |
| Configure database connection | `maiyu:backend-database-config` |
| Configure environment variables | `maiyu:backend-env` |
| Configure dependency injection | `maiyu:backend-di-registry` |
| Configure server bootstrap | `maiyu:backend-kernel` |
| Define project folder structure | `maiyu:backend-structure` |
| Add error handling / exceptions | `maiyu:backend-error-handling` |
| Add unit tests | `maiyu:backend-test` |
| Add E2E test setup | `maiyu:backend-e2e-test` |
| Add email service with templates | `maiyu:backend-email-template` |
| Add WebSocket / real-time | `maiyu:backend-realtime` |
| Add sandboxed script execution | `maiyu:backend-sandbox` |
| Add clone, import, or export | `maiyu:backend-clone-import-export` |

## Compound Tasks

- **"Create a CRUD for X"** — Invoke: `backend-scaffold`, `backend-controller`, `backend-service`, `backend-repository`, `backend-model`, `backend-schema`, `backend-validator`
- **"Set up the project"** — Invoke: `backend-structure`, `backend-kernel`, `backend-env`, `backend-database-config`, `backend-di-registry`
- **"Add authentication"** — Invoke: `backend-auth`, `backend-middleware`
- **"Add tests"** — Invoke: `backend-test`, `backend-e2e-test`

## Conventions

All generated code MUST follow these rules:

- **Zero `any`** — use concrete types, `unknown`, generics, `Record<string, unknown>`
- **Zero ternaries** — use if/else, early return, const mapper
- **Zero `as TYPE`** — use type guards, generics (except `as const`)
- **Explicit return types** on all functions
- **Multiple conditions** — const mapper (object lookup instead of switch/if-else chains)
- **Named exports only** — no default exports (except fastify-decorators)
- **Soft deletes by default** — `trashed: boolean`, `trashedAt: Date | null`
- **Either pattern** for error handling — left = error, right = success
