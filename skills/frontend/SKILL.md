---
name: frontend
description: |
  31 frontend development skills for React/Next.js/Vue projects.
  Use when: any frontend task — forms, components, pages, data tables,
  CRUD pages, kanban, calendar, file upload, filters, rich editor,
  permissions, RBAC, stores, routes, SEO, error screens, date pickers,
  field masks, tree navigation, settings pages, API services, etc.
  Frameworks: Next.js, TanStack Start, React (Vite), Remix, Vue.
  UI: shadcn, Radix, Tailwind, TanStack Table, TanStack Form, TanStack Query.
  State: Zustand, TanStack Query.
metadata:
  author: jhollyfer
  version: "1.0.0"
---

# Frontend Skills

When this skill is activated, you become a **maiyu-sh frontend agent** with access to 31 specialized modules. You MUST read the matching module before generating any code.

## How to Operate

1. **Detect the project** — Read `package.json` (walk up directories if needed) and identify:
   - **Framework**: `next` | `@tanstack/react-start` | `react` (Vite) | `@remix-run/react` | `vue`
   - **Form lib**: `@tanstack/react-form` | `react-hook-form` | `formik`
   - **Validation**: `zod` | `yup` | `valibot`
   - **UI**: `@radix-ui/*` | `shadcn` | `tailwindcss`
   - **Table**: `@tanstack/react-table`
   - **State**: `zustand` | `@tanstack/react-query`
2. **Identify the task** — Match to one or more modules below
3. **Read the module** — Use `Read` tool on the relative path (e.g., `modules/form.md`)
4. **Follow conventions** — All code MUST follow the rules below

## Task-to-Module Mapping

| Task | Module to read |
|------|---------------|
| Create a form / edit form / field component | `modules/form.md` |
| Create a dynamic form from definitions | `modules/dynamic-form.md` |
| Create a Zod validation schema | `modules/schema.md` |
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

## Compound Tasks

- **"Create a CRUD for X"** — Read: `crud-page`, `form`, `data-table`, `hook-query`
- **"Create a new page"** — Read: `next-page` or `route`, `page-shell`, `component`
- **"Create a form"** — Read: `form`, `schema`, `field-mask`, `datepicker`
- **"Add authentication"** — Read: `auth-store`, `permission`, `rbac`
- **"Add a filter"** — Read: `filter`, `data-table`

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
