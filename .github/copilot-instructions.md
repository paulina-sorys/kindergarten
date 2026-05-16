# Kindergarten Project Guidelines

This is a **Rails 8.1 + Vue 3 + Vite** full-stack application with Hotwire (Stimulus/Turbo) for real-time interactivity. Uses Mise for task management and Vitest for frontend testing.

## Architecture Overview

### Backend (Rails)
- Rails 8.1.3 with SQLite database
- MVC pattern: `app/models/`, `app/controllers/`, `app/views/`
- RESTful API routes in `config/routes.rb`
- Active Record for ORM
- Database migrations in `db/migrate/`

### Frontend (Vue + Vite)
- Vue 3 with Vite bundler (vite_rails gem)
- Vue components can be placed in `app/javascript/`
- Stimulus controllers in `app/javascript/controllers/` for lightweight interactivity
- Turbo for SPA-like navigation (`turbo-rails` gem)
- CSS with PostCSS and Autoprefixer in `app/assets/stylesheets/`

### Vite Build Tool
- **Bundler**: Vite with RubyPlugin integration via `vite_rails` gem
- **Configuration**: `vite.config.mts` at root (TypeScript config)
- **Entry points**: Vue components and JavaScript in `app/javascript/entrypoints/`
- **HMR (Hot Module Replacement)**: Automatically enabled in development—changes to Vue components reflect instantly without full page reload
- **Asset pipeline**: Vite works alongside Rails asset pipeline; Vite handles JS/Vue, Rails handles images and static assets
- **Build output**: Production builds generate optimized bundles with code splitting and tree-shaking
- **Development server**: Runs on port 5173 by default, served through Rails via `vite_rails` gem

### Testing
- **Frontend**: Vitest with Vue Test Utils, jsdom environment
- **Backend**: Rails minitest in `test/` directory
- Tests run: `mise run test`

## Build & Development

### Start Development Server
```bash
mise run dev
```
Runs both Rails server and Vite dev server in parallel. For troubleshooting, use `mise run fix-dev` to reset dependencies.

### Key Commands
- `bin/rails` - Rails CLI
- `yarn` or `npm` - Node package manager
- `bundle` - Ruby gem manager
- `mise tasks ls` - List all available tasks

## Code Style & Conventions

### Rails Backend
- Follow Rails conventions (models in `app/models/`, controllers in `app/controllers/`)
- Use RESTful routing with 7 standard actions where possible
- Database queries: prefer Active Record queries over raw SQL
- Use concerns for shared model/controller logic (`app/models/concerns/`, `app/controllers/concerns/`)
- Models should have User associations where relevant

### Vue/JavaScript Frontend
- Use single-file components (`.vue` files)
- Component location: `app/javascript/` (alias: `@`)
- Use `v-` directives for reactivity
- Prefer `<script setup>` syntax in Vue 3
- Keep components focused and reusable
- Use Stimulus controllers for DOM manipulation and interactivity

### Styling
- CSS in `app/assets/stylesheets/application.css`
- Autoprefixer adds browser prefixes automatically
- Use Tailwind or vanilla CSS (check current setup)

## Key Files
- **Routes**: `config/routes.rb`
- **Database schema**: `db/schema.rb`
- **Models**: `app/models/*.rb`
- **Controllers**: `app/controllers/*.rb`
- **Vue entry point**: `app/javascript/entrypoints/application.js`
- **Vite config**: `vite.config.mts`
- **Test config**: `vitest.config.js`, `test/test_helper.rb`
- **PostCSS config**: `postcss.config.js` (Autoprefixer for CSS)

## Important Constraints & Gotchas

- **Vite hot module replacement**: Works with Rails assets pipeline - no manual refresh needed in development
- **Vite entry points**: Only place bundles in `app/javascript/entrypoints/` for Vite to pick them up
- **Vite dev server**: Runs on port 5173; Rails automatically proxies through it in development
- **Vite asset imports**: Use relative imports (e.g., `import '@/components/MyComponent.vue'`) with the `@` alias pointing to `app/javascript/`
- **Vite build**: Run `yarn build` to generate optimized production bundles; output goes to `public/vite/`
- **Turbo + Stimulus interaction**: Be careful with event listeners when Turbo replaces DOM elements
- **Database migrations**: Always create new migrations, never edit old ones
- **Node version**: Fixed at 24 via Mise (see `mise.toml`)
- **Ruby version**: 4.0.3
- **Yarn version**: 3.8.7

## Common Workflows

### Adding a New Feature
1. Create Rails model and migration
2. Create controller actions (typically index, show, create, update, destroy)
3. Add routes in `config/routes.rb`
4. Build Vue components in `app/javascript/`
5. Wire up with Stimulus controller or Turbo if needed
6. Write tests for both backend and frontend

### Debugging
- Rails server output in terminal when running `mise run dev`
- Vite dev server logs for frontend bundling issues
- Browser console for Vue component errors
- `byebug` or `binding.irb` for Rails debugging

### Refactoring
- Extract repeated logic into concerns or helper methods
- Keep components small and focused
- Use Rails scopes for complex queries
- Consider performance implications for N+1 queries
