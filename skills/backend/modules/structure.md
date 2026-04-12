## Project Detection

Before generating structure, detect the project state:

1. Check if `package.json` exists in the target directory
2. If it exists, detect the current stack from `dependencies`/`devDependencies`:
   - **Framework**: `fastify` | `express` | `@nestjs/core` | `@adonisjs/core` | `hono` | `elysia`
   - **ORM**: `mongoose` | `@prisma/client` | `typeorm` | `drizzle-orm` | `knex` | `sequelize`
   - **DI**: `fastify-decorators` | `tsyringe` | `inversify` | `@nestjs/common` | `awilix` | manual
   - **Validator**: `zod` | `class-validator` | `joi` | `@sinclair/typebox`
   - **Test runner**: `vitest` | `jest`
3. Scan for existing directories to understand what already exists:
   - Entry point: `bin/server.ts` | `src/index.ts` | `src/main.ts` | `src/server.ts`
   - Bootstrap: `start/kernel.ts` | `src/app.ts` | `src/app.module.ts`
   - Application code: `application/` | `src/`
   - Resources/features: `application/resources/` | `src/modules/` | `src/routes/`
4. If this is a NEW project (no `package.json`), ask user:
   ```
   Qual framework deseja usar?
   1. Fastify (com fastify-decorators)
   2. Fastify (plain)
   3. Express
   4. NestJS
   5. AdonisJS
   6. Hono
   7. Elysia/Bun
   ```
   Then ask:
   ```
   Qual ORM/ODM?
   1. Mongoose (MongoDB)
   2. Prisma
   3. TypeORM
   4. Drizzle ORM
   5. Knex
   6. Sequelize
   ```

## Architecture Overview

### Layered Architecture with Feature-Based Organization

```
Controller → Use-Case → Repository → Model
     ↑            ↑           ↑
  Validator    Service     Contract
  Schema     (optional)   (abstract class)
```

### Layer Responsibilities

| Layer | Responsibility | Depends On |
|-------|---------------|------------|
| **Controller** | HTTP request/response, input parsing, status codes | Validator, Use-Case, Schema |
| **Use-Case** | Business logic, orchestration, error decisions | Repository Contract, Service Contract |
| **Repository** | Data access, CRUD operations, query building | Model/ORM |
| **Model** | Database schema definition, field types, indexes | Entity types |
| **Validator** | Input validation, type coercion, sanitization | Zod/class-validator |
| **Schema** | API documentation, OpenAPI/Swagger specs | — |
| **Service** | External integrations (email, storage, payment) | Provider SDKs |
| **Middleware** | Cross-cutting concerns (auth, logging, rate-limit) | JWT, Cookies |

### Error Flow

Use-cases return `Either<HTTPException, SuccessType>` — they NEVER throw.
Controllers check `isLeft()` / `isRight()` and send the appropriate HTTP response.
A global error handler catches unexpected errors (ZodError, framework errors, uncaught).

### Dependency Injection Flow

```
Contract (abstract class) ← Implementation (@Service decorator)
         ↑
    DI Registry maps Contract → Implementation
         ↑
    Use-Case receives Contract via constructor injection
```

## Directory Structure

### Fastify (Reference Implementation)

```
backend/
├── bin/
│   └── server.ts                         # Entry point — connects DB, boots kernel, listens
├── start/
│   ├── kernel.ts                         # App bootstrap — plugins, CORS, JWT, error handler, DI, controller discovery
│   └── env.ts                            # Env validation (Zod) — fail-fast at startup
├── config/
│   ├── database.config.ts                # Database connection (MongooseConnect, PrismaClient, etc.)
│   ├── email.config.ts                   # Email transport config
│   └── util.config.ts                    # Shared config constants
├── application/
│   ├── core/
│   │   ├── entity.core.ts                # Domain types (IUser, IProduct, etc.), enums, Base type, Merge, ValueOf
│   │   ├── exception.core.ts             # HTTPException class with static factory methods
│   │   ├── either.core.ts                # Either<L,R> monad — Left, Right, left(), right()
│   │   ├── util.core.ts                  # Shared utilities (regex, formatters, constants)
│   │   ├── controllers.ts                # Auto-discovery helper (if not using fastify-decorators bootstrap)
│   │   └── di-registry.ts                # Central DI registration — Contract → Implementation mappings
│   ├── middlewares/
│   │   ├── authentication.middleware.ts   # JWT/cookie verification, request.user injection
│   │   └── {purpose}.middleware.ts        # Additional middlewares (rate-limit, access-control, logging)
│   ├── model/
│   │   ├── user.model.ts                 # Mongoose schema + model export
│   │   └── {entity}.model.ts             # One file per entity
│   ├── repositories/
│   │   └── {entity}/
│   │       ├── {entity}-contract.repository.ts   # Abstract class + payload types
│   │       ├── {entity}-{orm}.repository.ts      # ORM implementation (@Service)
│   │       └── {entity}-in-memory.repository.ts  # In-memory implementation (for tests)
│   ├── services/
│   │   └── {service}/
│   │       ├── {service}-contract.service.ts      # Abstract class + input/output types
│   │       ├── {provider}-{service}.service.ts    # Provider implementation (@Service)
│   │       └── in-memory-{service}.service.ts     # In-memory implementation (for tests)
│   ├── resources/
│   │   └── {entity-plural}/
│   │       ├── {entity}-base.validator.ts         # Shared Zod fields for this entity
│   │       ├── create/
│   │       │   ├── create.controller.ts
│   │       │   ├── create.use-case.ts
│   │       │   ├── create.validator.ts
│   │       │   ├── create.schema.ts
│   │       │   ├── create.use-case.spec.ts
│   │       │   └── create.controller.spec.ts
│   │       ├── show/
│   │       │   └── ...
│   │       ├── paginated/
│   │       │   └── ...
│   │       ├── update/
│   │       │   └── ...
│   │       ├── delete/
│   │       │   └── ...
│   │       ├── send-to-trash/
│   │       │   └── ...
│   │       └── remove-from-trash/
│   │           └── ...
│   └── utils/
│       ├── cookies.util.ts
│       └── jwt.util.ts
├── database/
│   └── seeders/
│       ├── main.ts                        # Seeder runner
│       ├── 1720448435-permissions.seed.ts
│       ├── 1720448436-groups.seed.ts
│       └── 1720448437-users.seed.ts
├── _types/
│   └── fastify.d.ts                       # Module augmentation (request.user, etc.)
├── _storage/                              # Uploaded files (gitignored)
├── _locales/                              # i18n translation files
├── templates/
│   └── email/                             # Email EJS/HTML templates
├── test/
│   └── helpers/
│       └── auth.helper.ts                 # Test utilities
├── docs/                                  # API documentation
├── .env                                   # Environment variables (gitignored)
├── .env.example                           # Environment template (committed)
├── .env.test                              # Test environment (gitignored)
├── tsconfig.json
├── vitest.config.ts
└── package.json
```

### Express

```
backend/
├── src/
│   ├── index.ts                           # Entry point
│   ├── app.ts                             # Express app setup — middleware, routes, error handler
│   ├── config/
│   │   ├── env.ts
│   │   └── database.ts
│   ├── core/
│   │   ├── entity.core.ts
│   │   ├── exception.core.ts
│   │   ├── either.core.ts
│   │   └── util.core.ts
│   ├── middlewares/
│   │   ├── auth.middleware.ts
│   │   └── error-handler.middleware.ts    # Must be last middleware registered
│   ├── models/
│   │   └── {entity}.model.ts
│   ├── repositories/
│   │   └── {entity}/
│   │       ├── {entity}-contract.repository.ts
│   │       ├── {entity}-{orm}.repository.ts
│   │       └── {entity}-in-memory.repository.ts
│   ├── services/
│   │   └── {service}/
│   │       ├── {service}-contract.service.ts
│   │       ├── {provider}-{service}.service.ts
│   │       └── in-memory-{service}.service.ts
│   ├── resources/
│   │   └── {entity-plural}/
│   │       ├── {entity}-base.validator.ts
│   │       ├── create/
│   │       │   ├── create.router.ts       # Express Router with route handler
│   │       │   ├── create.use-case.ts
│   │       │   ├── create.validator.ts
│   │       │   └── create.use-case.spec.ts
│   │       └── ...
│   ├── container.ts                       # DI container (tsyringe/awilix/manual)
│   └── routes.ts                          # Central route registration
├── database/
│   └── seeders/
├── test/
├── .env
└── package.json
```

### NestJS

```
backend/
├── src/
│   ├── main.ts                            # Bootstrap — NestFactory.create, CORS, Swagger
│   ├── app.module.ts                      # Root module
│   ├── config/
│   │   ├── env.ts
│   │   └── database.module.ts
│   ├── core/
│   │   ├── entity.core.ts
│   │   ├── exception.core.ts
│   │   ├── either.core.ts
│   │   └── filters/
│   │       └── http-exception.filter.ts   # Global exception filter
│   ├── guards/
│   │   ├── auth.guard.ts
│   │   └── permission.guard.ts
│   ├── modules/
│   │   └── {entity-plural}/
│   │       ├── {entity-plural}.module.ts  # Feature module
│   │       ├── {entity-plural}.controller.ts
│   │       ├── model/
│   │       │   └── {entity}.schema.ts
│   │       ├── repositories/
│   │       │   ├── {entity}-contract.repository.ts
│   │       │   ├── {entity}-{orm}.repository.ts
│   │       │   └── {entity}-in-memory.repository.ts
│   │       ├── use-cases/
│   │       │   ├── create-{entity}.use-case.ts
│   │       │   ├── show-{entity}.use-case.ts
│   │       │   ├── paginated-{entity}.use-case.ts
│   │       │   ├── update-{entity}.use-case.ts
│   │       │   └── delete-{entity}.use-case.ts
│   │       ├── dto/
│   │       │   ├── create-{entity}.dto.ts
│   │       │   ├── update-{entity}.dto.ts
│   │       │   └── paginated-{entity}-query.dto.ts
│   │       └── tests/
│   │           └── create-{entity}.use-case.spec.ts
│   └── services/
│       └── {service}/
│           ├── {service}-contract.service.ts
│           ├── {provider}-{service}.service.ts
│           └── in-memory-{service}.service.ts
├── prisma/ or database/
├── test/
└── package.json
```

### Hono

```
backend/
├── src/
│   ├── index.ts                           # Entry point — Hono app, serve()
│   ├── app.ts                             # Hono() setup — middleware, routes
│   ├── config/
│   │   ├── env.ts
│   │   └── database.ts
│   ├── core/
│   │   ├── entity.core.ts
│   │   ├── exception.core.ts
│   │   ├── either.core.ts
│   │   └── util.core.ts
│   ├── middlewares/
│   │   └── auth.middleware.ts
│   ├── models/
│   │   └── {entity}.model.ts
│   ├── repositories/
│   │   └── {entity}/
│   ├── services/
│   │   └── {service}/
│   ├── resources/
│   │   └── {entity-plural}/
│   │       ├── {entity}-base.validator.ts
│   │       ├── create/
│   │       │   ├── create.route.ts        # Hono route handler
│   │       │   ├── create.use-case.ts
│   │       │   ├── create.validator.ts
│   │       │   └── create.use-case.spec.ts
│   │       └── ...
│   ├── container.ts
│   └── routes.ts
├── database/
├── test/
└── package.json
```

### Elysia/Bun

```
backend/
├── src/
│   ├── index.ts                           # Entry point — Elysia().listen()
│   ├── app.ts                             # Elysia() setup — plugins, middleware
│   ├── config/
│   │   ├── env.ts
│   │   └── database.ts
│   ├── core/
│   │   ├── entity.core.ts
│   │   ├── exception.core.ts
│   │   ├── either.core.ts
│   │   └── util.core.ts
│   ├── middlewares/
│   │   └── auth.middleware.ts             # Elysia derive/onBeforeHandle
│   ├── models/
│   │   └── {entity}.model.ts
│   ├── repositories/
│   │   └── {entity}/
│   ├── services/
│   │   └── {service}/
│   ├── resources/
│   │   └── {entity-plural}/
│   │       ├── {entity}-base.validator.ts
│   │       ├── create/
│   │       │   ├── create.plugin.ts       # Elysia plugin with route
│   │       │   ├── create.use-case.ts
│   │       │   ├── create.validator.ts
│   │       │   └── create.use-case.spec.ts
│   │       └── ...
│   └── container.ts
├── database/
├── test/
└── package.json
```

### AdonisJS

```
backend/
├── start/
│   ├── kernel.ts                          # Middleware stack registration
│   ├── routes.ts                          # Route definitions
│   └── env.ts                             # Env validation (@adonisjs/env)
├── config/
│   ├── database.ts
│   ├── auth.ts
│   └── app.ts
├── app/
│   ├── core/
│   │   ├── entity.core.ts
│   │   ├── exception.core.ts
│   │   ├── either.core.ts
│   │   └── util.core.ts
│   ├── middleware/
│   │   └── auth.middleware.ts
│   ├── models/
│   │   └── {entity}.ts                    # Lucid ORM model
│   ├── repositories/
│   │   └── {entity}/
│   │       ├── {entity}-contract.repository.ts
│   │       ├── {entity}-lucid.repository.ts
│   │       └── {entity}-in-memory.repository.ts
│   ├── services/
│   │   └── {service}/
│   ├── controllers/
│   │   └── {entity-plural}/
│   │       ├── create.controller.ts
│   │       ├── show.controller.ts
│   │       └── ...
│   ├── use-cases/
│   │   └── {entity-plural}/
│   │       ├── create.use-case.ts
│   │       └── ...
│   └── validators/
│       └── {entity-plural}/
│           ├── create.validator.ts
│           └── ...
├── database/
│   ├── migrations/
│   └── seeders/
├── tests/
└── package.json
```

## Naming Conventions

### File Naming

| Layer | Pattern | Example |
|-------|---------|---------|
| Entry point | `server.ts` | `bin/server.ts` |
| Bootstrap | `kernel.ts` | `start/kernel.ts` |
| Env | `env.ts` | `start/env.ts` |
| Config | `{purpose}.config.ts` | `database.config.ts` |
| Entity types | `entity.core.ts` | `application/core/entity.core.ts` |
| Exception | `exception.core.ts` | `application/core/exception.core.ts` |
| Either | `either.core.ts` | `application/core/either.core.ts` |
| DI registry | `di-registry.ts` | `application/core/di-registry.ts` |
| Model | `{entity}.model.ts` | `user.model.ts` |
| Contract repo | `{entity}-contract.repository.ts` | `user-contract.repository.ts` |
| ORM repo | `{entity}-{orm}.repository.ts` | `user-mongoose.repository.ts` |
| In-memory repo | `{entity}-in-memory.repository.ts` | `user-in-memory.repository.ts` |
| Contract service | `{service}-contract.service.ts` | `email-contract.service.ts` |
| Provider service | `{provider}-{service}.service.ts` | `nodemailer-email.service.ts` |
| In-memory service | `in-memory-{service}.service.ts` | `in-memory-email.service.ts` |
| Middleware | `{purpose}.middleware.ts` | `authentication.middleware.ts` |
| Controller | `{action}.controller.ts` | `create.controller.ts` |
| Use-case | `{action}.use-case.ts` | `create.use-case.ts` |
| Validator | `{action}.validator.ts` | `create.validator.ts` |
| Base validator | `{entity}-base.validator.ts` | `product-base.validator.ts` |
| Schema | `{action}.schema.ts` | `create.schema.ts` |
| Unit test | `{action}.use-case.spec.ts` | `create.use-case.spec.ts` |
| E2E test | `{action}.controller.spec.ts` | `create.controller.spec.ts` |
| Seeder | `{timestamp}-{entity}.seed.ts` | `1720448435-permissions.seed.ts` |

### Class/Type Naming

| Concept | Pattern | Example |
|---------|---------|---------|
| Entity type | `I{Entity}` | `IUser`, `IProduct` |
| Enum | `E_{ENTITY}_{FIELD}` | `E_USER_STATUS`, `E_PRODUCT_TYPE` |
| Contract repo | `{Entity}ContractRepository` | `UserContractRepository` |
| ORM repo | `{Entity}{Orm}Repository` | `UserMongooseRepository` |
| In-memory repo | `{Entity}InMemoryRepository` | `UserInMemoryRepository` |
| Contract service | `{Service}ContractService` | `EmailContractService` |
| Provider service | `{Provider}{Service}Service` | `NodemailerEmailService` |
| Use-case | `{Entity}{Action}UseCase` | `UserCreateUseCase` |
| Create payload | `{Entity}CreatePayload` | `UserCreatePayload` |
| Update payload | `{Entity}UpdatePayload` | `UserUpdatePayload` |
| Find payload | `{Entity}FindByPayload` | `UserFindByPayload` |
| Query payload | `{Entity}QueryPayload` | `UserQueryPayload` |
| Body validator | `{Entity}{Action}BodyValidator` | `UserCreateBodyValidator` |
| Params validator | `{Entity}{Action}ParamValidator` | `UserShowParamValidator` |
| Query validator | `{Entity}{Action}QueryValidator` | `UserPaginatedQueryValidator` |
| Schema | `{Entity}{Action}Schema` | `UserCreateSchema` |

### Directory Naming

- **Entity directories in resources** use the **plural** form: `users/`, `products/`, `table-rows/`
- **Repository/service directories** use the **singular** form: `user/`, `email/`
- **Action directories** use **kebab-case**: `create/`, `show/`, `paginated/`, `send-to-trash/`, `remove-from-trash/`

## New Project Generation Order

When creating a new project from scratch, generate in this order:

### Phase 1: Foundation

1. `package.json` — with framework, ORM, validator, test runner dependencies
2. `tsconfig.json` — with path aliases (`@application/`, `@start/`, `@config/`, `@test/`)
3. `.env.example` — template with all required env vars
4. `start/env.ts` — env validation (delegate to `backend-env` skill)

### Phase 2: Core

5. `application/core/entity.core.ts` — Base type, Merge, ValueOf, IMeta
6. `application/core/either.core.ts` — Either monad (Left/Right)
7. `application/core/exception.core.ts` — HTTPException factory
8. `application/core/util.core.ts` — shared utilities
9. `application/core/di-registry.ts` — empty registry function

### Phase 3: Infrastructure

10. `config/database.config.ts` — database connection (delegate to `backend-kernel`)
11. `start/kernel.ts` — app bootstrap (delegate to `backend-kernel`)
12. `bin/server.ts` — entry point
13. `application/middlewares/authentication.middleware.ts` — auth middleware (delegate to `backend-middleware`)

### Phase 4: First Entity (User)

14. Entity type — add `IUser` to `entity.core.ts` (delegate to `backend-model`)
15. Model — `user.model.ts` (delegate to `backend-model`)
16. Repository — contract + ORM + in-memory (delegate to `backend-repository`)
17. DI registration — update `di-registry.ts` (delegate to `backend-di-registry`)
18. Resources — scaffold CRUD actions (delegate to `backend-scaffold`)

### Phase 5: Services

19. Email service — contract + implementation + in-memory (delegate to `backend-service`)
20. DI registration — update `di-registry.ts`

### Phase 6: Database

21. Seeders — permissions, groups, users (delegate to `backend-seeder`)

### Phase 7: Testing & Docs

22. Test helpers — `test/helpers/auth.helper.ts`
23. `vitest.config.ts` — test configuration
24. Type augmentations — `_types/fastify.d.ts`
25. Health check — `application/resources/health-check.controller.ts`

## Adding a New Feature/Resource

When adding a new entity to an existing project:

1. **Entity type** — add `I{Entity}` and enums to `entity.core.ts`
2. **Model** — create `application/model/{entity}.model.ts` (delegate to `backend-model`)
3. **Repository** — create `application/repositories/{entity}/` with contract + ORM + in-memory (delegate to `backend-repository`)
4. **DI registration** — add to `di-registry.ts` (delegate to `backend-di-registry`)
5. **Base validator** — create `resources/{entities}/{entity}-base.validator.ts` (delegate to `backend-validator`)
6. **For each action**:
   a. `{action}.validator.ts` (delegate to `backend-validator`)
   b. `{action}.schema.ts` (delegate to `backend-schema`)
   c. `{action}.use-case.ts` (delegate to `backend-use-case`)
   d. `{action}.controller.ts` (delegate to `backend-controller`)
   e. `{action}.use-case.spec.ts` (delegate to `backend-test`)
7. **Seeder** — create `database/seeders/{timestamp}-{entities}.seed.ts` if needed (delegate to `backend-seeder`)

## Adding a New Service

1. **Contract** — create `application/services/{service}/{service}-contract.service.ts` (delegate to `backend-service`)
2. **Implementation** — create `application/services/{service}/{provider}-{service}.service.ts`
3. **In-memory** — create `application/services/{service}/in-memory-{service}.service.ts`
4. **DI registration** — add to `di-registry.ts`
5. **Env vars** — add provider credentials to `start/env.ts` and `.env.example` (delegate to `backend-env`)
6. **Config** — create `config/{service}.config.ts` if needed

## Adding a New Middleware

1. Create `application/middlewares/{purpose}.middleware.ts` (delegate to `backend-middleware`)
2. Use factory function pattern — accept options object, return handler function
3. Apply to controllers via decorator options (Fastify) or guards (NestJS) or router.use (Express)

## Framework Adaptation Rules

### Controller File Differences

| Framework | Controller Pattern | File Name | Export Style |
|-----------|-------------------|-----------|--------------|
| Fastify (decorators) | `@Controller()` class with `@POST/@GET` methods | `{action}.controller.ts` | Anonymous default export |
| Fastify (plain) | Route function registered via `app.register()` | `{action}.controller.ts` | Named function export |
| Express | `Router()` with `.post/.get` handlers | `{action}.router.ts` | Default router export |
| NestJS | `@Controller()` class with `@Post/@Get` methods | `{entity-plural}.controller.ts` | Named class export |
| Hono | `new Hono()` with `.post/.get` handlers | `{action}.route.ts` | Default app export |
| Elysia | `new Elysia()` with `.post/.get` handlers | `{action}.plugin.ts` | Default app export |
| AdonisJS | Class with `handle()` method | `{action}.controller.ts` | Default class export |

### DI Differences

| Framework | DI Decorator | Registration |
|-----------|-------------|--------------|
| Fastify (decorators) | `@Service()` | `injectablesHolder.injectService(Contract, Impl)` |
| tsyringe | `@injectable()` | `container.register(Contract, { useClass: Impl })` |
| inversify | `@injectable()` | `container.bind<Contract>(TYPES.X).to(Impl)` |
| NestJS | `@Injectable()` | Module `providers: [{ provide: Contract, useClass: Impl }]` |
| awilix | None | `container.register({ name: asClass(Impl) })` |
| Manual | None | `new UseCase(new Repository())` |

## Rules

- No ternary operators — use if/else or early returns
- No `any` type — use `unknown`, concrete types, generics, or `Record<string, unknown>`
- No `as TYPE` assertions (except `as const`) — use type guards, generics, or proper typing
- All functions must have explicit return types
- Multiple conditions use const mapper (object lookup) instead of switch/if-else chains
- `abstract class` for contracts, not `interface` (required for runtime DI)
- Payload types defined IN the contract file
- One use-case per action (Single Responsibility Principle)
- Use-cases return `Either<HTTPException, T>` — never throw
- Controllers check Either result and send appropriate HTTP response
- Soft deletes as default (`trashed: boolean`, `trashedAt: Date | null`)
- Timestamps on all models (`createdAt`, `updatedAt`)
- Import paths use project aliases (`@application/`, `@start/`, `@config/`, `@test/`)
- Detect project language for user-facing strings (pt-BR vs en-US)
- Feature-based folder organization in resources (one action per folder)

## Delegate to Specialized Skills

This skill defines WHERE files go. For HOW to generate file content, delegate to:

| File Type | Delegate To |
|-----------|-------------|
| Model | `backend-model` |
| Repository (contract + impl + in-memory) | `backend-repository` |
| Service (contract + impl + in-memory) | `backend-service` |
| Controller | `backend-controller` |
| Use-case | `backend-use-case` |
| Validator | `backend-validator` |
| Schema | `backend-schema` |
| Middleware | `backend-middleware` |
| Test (unit + E2E) | `backend-test` |
| Seeder | `backend-seeder` |
| Error handling (Either + HTTPException) | `backend-error-handling` |
| DI registry | `backend-di-registry` |
| Env validation | `backend-env` |
| Kernel/bootstrap | `backend-kernel` |
| Auth module | `backend-auth` |
| Full CRUD scaffold | `backend-scaffold` |
| Email templates | `backend-email-template` |
| E2E tests | `backend-e2e-test` |

## Checklists

### New Project

- [ ] `package.json` with all dependencies
- [ ] `tsconfig.json` with path aliases
- [ ] `.env.example` with all required vars
- [ ] `start/env.ts` validates env at startup
- [ ] `application/core/` has entity.core, either.core, exception.core, util.core, di-registry
- [ ] `config/database.config.ts` connects to database
- [ ] `start/kernel.ts` bootstraps the app (CORS, JWT, cookies, error handler, DI, controllers)
- [ ] `bin/server.ts` starts the server
- [ ] Authentication middleware created
- [ ] At least one entity (User) fully scaffolded with all layers
- [ ] Email service with contract + implementation + in-memory
- [ ] DI registry maps all contracts to implementations
- [ ] Seeders for initial data (permissions, groups, admin user)
- [ ] Health check endpoint exists
- [ ] Test configuration (`vitest.config.ts`) set up
- [ ] Type augmentations for framework (`_types/`)

### New Feature/Resource

- [ ] Entity type added to `entity.core.ts`
- [ ] Model created with all fields, timestamps, soft-delete
- [ ] Repository contract has all payload types and abstract methods
- [ ] Repository implementation with `@Service()` decorator
- [ ] Repository in-memory for testing
- [ ] Repository registered in DI registry
- [ ] Base validator created with shared fields
- [ ] All selected action directories created with all files (controller, use-case, validator, schema, test)
- [ ] All controllers are loadable by the bootstrap system
- [ ] All unit tests pass independently (in-memory repos)
- [ ] Import paths use project aliases

### New Service

- [ ] Contract defines all abstract methods with typed inputs/outputs
- [ ] Implementation uses `@Service()` decorator
- [ ] In-memory implementation records calls for test verification
- [ ] Registered in DI registry
- [ ] Env vars added to `start/env.ts` and `.env.example`
- [ ] Config file created if needed
