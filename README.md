# maiyu-skills

60+ skills para desenvolvimento fullstack com AI coding agents. Suporta Fastify, Express, NestJS, AdonisJS, Hono, Elysia, Next.js, React, Vue e mais.

[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Compatible-blue?style=flat-square)](https://github.com/vercel-labs/agent-skills)
[![GitHub stars](https://img.shields.io/github/stars/jhollyfer/maiyu-skills?style=flat-square&color=yellow)](https://github.com/jhollyfer/maiyu-skills/stargazers)
[![AI Supported](https://img.shields.io/badge/AI_Supported-Claude_%7C_Cursor_%7C_Copilot_%7C_Codex_%7C_Windsurf-black?style=flat-square)](#)
[![Skills](https://img.shields.io/badge/Skills-59-white?style=flat-square&color=gray)](#skills)

## Installing

Works via CLI for all major AI coding agents (Claude Code, Cursor, Copilot, Codex, Windsurf, Antigravity, etc.):

```bash
npx skills add https://github.com/jhollyfer/maiyu-skills --all
```

### Claude Code (plugin nativo)

```bash
claude plugin marketplace add jhollyfer/maiyu-skills-marketplace
claude plugin install maiyu-skills
```

### Uso local (sem instalar)

```bash
claude --plugin-dir /caminho/para/maiyu-skills
```

## Skills

### Backend (24)

| Skill | Description |
|-------|-------------|
| **backend-auth** | Modulos completos de autenticacao |
| **backend-clone-import-export** | Endpoints de clone, import e export |
| **backend-controller** | Controllers/route handlers HTTP |
| **backend-database-config** | Configuracao de conexao com banco de dados |
| **backend-di-registry** | Registry de injecao de dependencias |
| **backend-e2e-test** | Setup e helpers de testes E2E |
| **backend-email-template** | Servico de email com templates EJS |
| **backend-env** | Validacao de variaveis de ambiente |
| **backend-error-handling** | Sistemas de tratamento de erros |
| **backend-kernel** | Bootstrap/kernel do servidor |
| **backend-middleware** | Middlewares e hooks |
| **backend-migration** | Migrations de banco de dados |
| **backend-model** | Models/entities |
| **backend-realtime** | Comunicacao em tempo real (WebSocket) |
| **backend-repository** | Repository pattern (contrato + implementacao + in-memory) |
| **backend-sandbox** | Execucao sandboxed de scripts |
| **backend-scaffold** | Scaffold completo de CRUD |
| **backend-schema** | Schemas de API/documentacao |
| **backend-seeder** | Seeders de banco de dados |
| **backend-service** | Service pattern (contrato + implementacao) |
| **backend-structure** | Estrutura de pastas e arquivos |
| **backend-test** | Testes unitarios e E2E |
| **backend-use-case** | Use cases/logica de negocio |
| **backend-validator** | Validacao de dados |

### Frontend (31)

| Skill | Description |
|-------|-------------|
| **frontend-api-service** | Camada de cliente API |
| **frontend-auth-store** | Estado de autenticacao com Zustand |
| **frontend-calendar-view** | Componentes de calendario (mes, semana, agenda) |
| **frontend-component** | Componentes React |
| **frontend-crud-page** | Paginas CRUD completas |
| **frontend-data-table** | Data tables com TanStack Table |
| **frontend-data-table-patterns** | DataTable generico com virtualizacao |
| **frontend-datepicker** | Datepicker com selecao single/range |
| **frontend-dynamic-form** | Formularios dinamicos a partir de definicoes |
| **frontend-error-screens** | Telas de erro, loading e empty state |
| **frontend-field-mask** | Mascaras de input |
| **frontend-file-upload** | Upload de arquivos (compound components) |
| **frontend-filter** | Sistemas de filtro baseados em URL |
| **frontend-form** | Formularios e componentes de campo |
| **frontend-hook-query** | Hooks TanStack Query (queries e mutations) |
| **frontend-kanban** | Kanban board com drag-and-drop |
| **frontend-next-page** | Paginas Next.js App Router |
| **frontend-page-shell** | Layout shell (Header/Content/Footer) |
| **frontend-permission** | Sistemas de permissao e RBAC |
| **frontend-query-patterns** | Patterns de TanStack Query |
| **frontend-rbac** | Role-based access control |
| **frontend-rich-editor** | Editor rich text com TipTap |
| **frontend-route** | Definicoes de rotas file-based |
| **frontend-schema** | Schemas Zod de validacao |
| **frontend-seo** | Configuracao SEO |
| **frontend-settings-page** | Paginas de configuracao do sistema |
| **frontend-store** | Stores Zustand |
| **frontend-tree-component** | Componentes de arvore hierarquica |
| **frontend-tree-navigation** | Navegacao hierarquica |
| **frontend-ui** | Componentes UI primitivos (shadcn/Radix) |
| **frontend-view** | Tipos de visualizacao (lista, card, kanban, calendario) |

### DevOps (3)

| Skill | Description |
|-------|-------------|
| **devops-docker-compose** | Docker Compose para diferentes ambientes |
| **devops-dockerfile** | Dockerfiles para projetos Node.js |
| **devops-github-actions** | Workflows CI/CD com GitHub Actions |

### Fullstack (1)

| Skill | Description |
|-------|-------------|
| **fullstack-monorepo** | Setup de monorepo fullstack |

## Conventions

All skills enforce these code conventions:

1. Zero `any` — use concrete types, `unknown`, generics
2. Zero ternaries — use if/else, early return, const mapper
3. Zero `as TYPE` (except `as const`) — use type guards, generics
4. Explicit return types — all functions and components must have typed returns
5. Multiple conditions → const mapper (object lookup)

## Author

[@jhollyfer](https://github.com/jhollyfer)
