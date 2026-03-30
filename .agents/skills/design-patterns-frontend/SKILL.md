# Frontend Design Patterns Skill

## Purpose
Apply frontend architecture and design patterns consistently in apps/frontend.

## Scope
- apps/frontend
- UI component composition
- data-fetching boundaries in client code
- frontend environment configuration

## Source of truth
- docs/architecture/design-patterns.md

## Instructions for agents
1. Read docs/architecture/design-patterns.md before proposing or generating frontend code.
2. Prefer feature-oriented organization as complexity grows.
3. Keep data-fetching logic in dedicated hooks or equivalent boundaries.
4. Keep UI components stateless when possible and move behavior to clear layers.
5. Use VITE_ environment variables for runtime configuration.
6. Avoid hard-coded backend URLs and secrets.

## Validation checklist
- Frontend code follows feature boundaries.
- Data-fetching is not scattered across unrelated UI components.
- No hard-coded endpoints or credentials.
- Any pattern exception is documented in PR notes.
