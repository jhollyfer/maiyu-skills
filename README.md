# maiyu-sh

60+ skills para desenvolvimento fullstack com AI coding agents. Suporta Fastify, Express, NestJS, AdonisJS, Hono, Elysia, Next.js, React, Vue e mais.

[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Compatible-blue?style=flat-square)](https://github.com/vercel-labs/agent-skills)
[![GitHub stars](https://img.shields.io/github/stars/jhollyfer/maiyu-skills?style=flat-square&color=yellow)](https://github.com/jhollyfer/maiyu-skills/stargazers)
[![AI Supported](https://img.shields.io/badge/AI_Supported-Claude_%7C_Cursor_%7C_Copilot_%7C_Codex_%7C_Windsurf-black?style=flat-square)](#)
[![Skills](https://img.shields.io/badge/Skills-60-white?style=flat-square&color=gray)](#skills)

## Installing

```bash
npx skills add https://github.com/jhollyfer/maiyu-skills
```

The installer will ask you:

1. **Which skills** — Backend, Frontend, DevOps, or all
2. **Which agents** — Claude Code, Cursor, Copilot, Windsurf, Codex, and more
3. **Scope** — Project or Global
4. **Method** — Symlink (recommended) or Copy

### Manual install

```bash
git clone https://github.com/jhollyfer/maiyu-skills.git
cd maiyu-skills
./install.sh
```

### Claude Code (direct)

```bash
claude --plugin-dir /path/to/maiyu-sh-skills
```

## Skills

### Backend (25 modules)

Controllers, services, repositories, models, auth, middleware, migrations, testing, scaffolding, seeders, validators, error handling, WebSocket, email templates, environment variables, dependency injection, monorepo setup.

**Frameworks:** Fastify, Express, NestJS, AdonisJS, Hono, Elysia/Bun

| Module | Description |
|--------|-------------|
| `auth` | Modulos completos de autenticacao (JWT, OAuth2, sessions) |
| `clone-import-export` | Endpoints de clone, import e export |
| `controller` | Controllers/route handlers HTTP |
| `database-config` | Configuracao de conexao com banco de dados |
| `di-registry` | Registry de injecao de dependencias |
| `e2e-test` | Setup e helpers de testes E2E |
| `email-template` | Servico de email com templates EJS |
| `env` | Validacao de variaveis de ambiente |
| `error-handling` | Sistemas de tratamento de erros |
| `kernel` | Bootstrap/kernel do servidor |
| `middleware` | Middlewares e hooks |
| `migration` | Migrations de banco de dados |
| `model` | Models/entities |
| `realtime` | Comunicacao em tempo real (WebSocket) |
| `repository` | Repository pattern (contrato + implementacao + in-memory) |
| `sandbox` | Execucao sandboxed de scripts |
| `scaffold` | Scaffold completo de CRUD |
| `schema` | Schemas de API/documentacao |
| `seeder` | Seeders de banco de dados |
| `service` | Service pattern (contrato + implementacao) |
| `structure` | Estrutura de pastas e arquivos |
| `test` | Testes unitarios e E2E |
| `use-case` | Use cases/logica de negocio |
| `validator` | Validacao de dados |
| `fullstack-monorepo` | Setup de monorepo fullstack |

### Frontend (31 modules)

Forms, components, data tables, CRUD pages, kanban, calendar, file upload, filters, rich editor, permissions, RBAC, stores, routes, SEO, error screens, date pickers, field masks, tree navigation, settings pages, API services.

**Frameworks:** Next.js, TanStack Start, React (Vite), Remix, Vue

| Module | Description |
|--------|-------------|
| `api-service` | Camada de cliente API |
| `auth-store` | Estado de autenticacao com Zustand |
| `calendar-view` | Componentes de calendario (mes, semana, agenda) |
| `component` | Componentes React |
| `crud-page` | Paginas CRUD completas |
| `data-table` | Data tables com TanStack Table |
| `data-table-patterns` | DataTable generico com virtualizacao |
| `datepicker` | Datepicker com selecao single/range |
| `dynamic-form` | Formularios dinamicos a partir de definicoes |
| `error-screens` | Telas de erro, loading e empty state |
| `field-mask` | Mascaras de input |
| `file-upload` | Upload de arquivos (compound components) |
| `filter` | Sistemas de filtro baseados em URL |
| `form` | Formularios e componentes de campo |
| `hook-query` | Hooks TanStack Query (queries e mutations) |
| `kanban` | Kanban board com drag-and-drop |
| `next-page` | Paginas Next.js App Router |
| `page-shell` | Layout shell (Header/Content/Footer) |
| `permission` | Sistemas de permissao e RBAC |
| `query-patterns` | Patterns de TanStack Query |
| `rbac` | Role-based access control |
| `rich-editor` | Editor rich text com TipTap |
| `route` | Definicoes de rotas file-based |
| `schema` | Schemas Zod de validacao |
| `seo` | Configuracao SEO |
| `settings-page` | Paginas de configuracao do sistema |
| `store` | Stores Zustand |
| `tree-component` | Componentes de arvore hierarquica |
| `tree-navigation` | Navegacao hierarquica |
| `ui` | Componentes UI primitivos (shadcn/Radix) |
| `view` | Tipos de visualizacao (lista, card, kanban, calendario) |

### DevOps (3 modules)

Dockerfile, Docker Compose, and GitHub Actions CI/CD workflows for Node.js projects.

| Module | Description |
|--------|-------------|
| `dockerfile` | Dockerfiles para projetos Node.js |
| `docker-compose` | Docker Compose para diferentes ambientes |
| `github-actions` | Workflows CI/CD com GitHub Actions |

## Conventions

All skills enforce these code conventions:

1. Zero `any` — use concrete types, `unknown`, generics
2. Zero ternaries — use if/else, early return, const mapper
3. Zero `as TYPE` (except `as const`) — use type guards, generics
4. Explicit return types — all functions and components must have typed returns
5. Multiple conditions — const mapper (object lookup)

## Author

[@jhollyfer](https://github.com/jhollyfer)
