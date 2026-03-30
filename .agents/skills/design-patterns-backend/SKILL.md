# Backend Design Patterns Skill

## Purpose
Apply backend architecture and persistence patterns consistently in apps/backend.

## Scope
- apps/backend
- API contracts and status semantics
- service-layer business logic
- persistence and database interaction patterns

## Source of truth
- docs/architecture/design-patterns.md

## Instructions for agents
1. Read docs/architecture/design-patterns.md before proposing or generating backend code.
2. Keep layering explicit: controller, service, repository, entity/dto.
3. Keep controllers thin and move business rules into services.
4. Keep API routes under /api with explicit and consistent HTTP status codes.
5. Prefer predictable error payloads and centralized exception handling patterns.
6. Keep persistence changes backward compatible and migration-friendly.
7. Use environment variables for datasource and runtime config.

## Validation checklist
- Layering is preserved and responsibilities are clear.
- API and error conventions are respected.
- No hard-coded credentials or connection strings.
- Database-impacting changes document migration strategy.
