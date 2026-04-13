---
name: maiyu:frontend
description: |
  Activates ALL 31 frontend skills for web projects.
  Use when: any frontend task — forms, components, data tables, CRUD pages,
  kanban, calendar, file upload, filters, rich editor, permissions, RBAC,
  stores, routes, SEO, error screens, date pickers, field masks,
  tree navigation, settings pages, API services.
  Frameworks: Next.js, TanStack Start, React (Vite), Remix, Vue.
  UI: shadcn, Radix, Tailwind, TanStack Table, TanStack Form, TanStack Query.
  State: Zustand, TanStack Query.
metadata:
  author: jhollyfer
  version: "1.0.0"
---

# maiyu:frontend — All Frontend Skills

When this skill is activated, you have access to **all 31 frontend skills**. Identify the task and read the matching skill before generating code.

## How to Operate

1. **Detect the project** — Read `package.json` (walk up directories if needed) and identify:
   - **Framework**: `next` | `@tanstack/react-start` | `react` (Vite) | `@remix-run/react` | `vue`
   - **Form lib**: `@tanstack/react-form` | `react-hook-form` | `formik`
   - **UI**: `@radix-ui/*` | `shadcn` | `tailwindcss`
   - **Table**: `@tanstack/react-table`
   - **State**: `zustand` | `@tanstack/react-query`
   - **Validator**: `zod` | `class-validator` | `joi`
   - **Package manager**: `npm` | `pnpm` | `yarn`
2. **Identify the task** — Match to the skill below
3. **Read the skill** — Use `Skill` tool to invoke the specific `maiyu:frontend-*` skill
4. **Follow conventions** — All code MUST follow the rules below

## Available Skills

| Task | Skill to invoke |
|------|----------------|
| Create a form / edit form | `maiyu:frontend-form` |
| Create a dynamic form from definitions | `maiyu:frontend-dynamic-form` |
| Create a Zod validation schema | `maiyu:frontend-schema` |
| Create a React component | `maiyu:frontend-component` |
| Create a complete CRUD page | `maiyu:frontend-crud-page` |
| Create a data table | `maiyu:frontend-data-table` |
| Advanced data table with virtualization | `maiyu:frontend-data-table-patterns` |
| Create a date picker (single/range) | `maiyu:frontend-datepicker` |
| Create error/loading/empty screens | `maiyu:frontend-error-screens` |
| Add input masks | `maiyu:frontend-field-mask` |
| Add file upload component | `maiyu:frontend-file-upload` |
| Create URL-based filter system | `maiyu:frontend-filter` |
| Create TanStack Query hooks | `maiyu:frontend-hook-query` |
| TanStack Query patterns | `maiyu:frontend-query-patterns` |
| Create kanban board | `maiyu:frontend-kanban` |
| Create a calendar view | `maiyu:frontend-calendar-view` |
| Create a Next.js App Router page | `maiyu:frontend-next-page` |
| Create page shell layout | `maiyu:frontend-page-shell` |
| Add permission system | `maiyu:frontend-permission` |
| Add role-based access control | `maiyu:frontend-rbac` |
| Create a rich text editor | `maiyu:frontend-rich-editor` |
| Define file-based routes | `maiyu:frontend-route` |
| Configure SEO | `maiyu:frontend-seo` |
| Create system settings page | `maiyu:frontend-settings-page` |
| Create Zustand store | `maiyu:frontend-store` |
| Create auth store (Zustand) | `maiyu:frontend-auth-store` |
| Create API client / service | `maiyu:frontend-api-service` |
| Create tree/hierarchical component | `maiyu:frontend-tree-component` |
| Create tree navigation | `maiyu:frontend-tree-navigation` |
| Create UI primitives (shadcn/Radix) | `maiyu:frontend-ui` |
| Create view type (list/card/kanban) | `maiyu:frontend-view` |

## Compound Tasks

- **"Create a CRUD for X"** — Invoke: `frontend-crud-page`, `frontend-form`, `frontend-data-table`, `frontend-hook-query`
- **"Create a new page"** — Invoke: `frontend-next-page` or `frontend-route`, `frontend-page-shell`, `frontend-component`
- **"Create a form"** — Invoke: `frontend-form`, `frontend-schema`, `frontend-field-mask`, `frontend-datepicker`
- **"Add authentication"** — Invoke: `frontend-auth-store`, `frontend-permission`, `frontend-rbac`
- **"Add a filter"** — Invoke: `frontend-filter`, `frontend-data-table`

## Conventions

All generated code MUST follow these rules:

- **Zero `any`** — use concrete types, `unknown`, generics, `Record<string, unknown>`
- **Zero ternaries** — use if/else, early return, const mapper
- **Zero `as TYPE`** — use type guards, generics (except `as const`)
- **Explicit return types** on all functions and components
- **Multiple conditions** — const mapper (object lookup instead of switch/if-else chains)
- **Named exports only** — no default exports
- **Compound components** with `data-slot` attributes
- **No prop drilling** — use context/hooks
