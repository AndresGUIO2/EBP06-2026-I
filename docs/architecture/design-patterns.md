# Design Patterns and Conventions

## Goal
Provide a stable architecture baseline that every agent must follow.

## Repository architecture
- Monorepo layout:
  - apps/frontend for Vite + React + TypeScript.
  - apps/backend for Spring Boot + Data JPA + Hibernate.
  - packages for shared code.
  - infra for infrastructure definitions.
  - .agents for agent governance and skills.

## Frontend patterns
- Use feature-oriented folder grouping once domain code grows.
- Keep data-fetching logic in dedicated hooks.
- Use environment variables from Vite with VITE_ prefix.
- Keep UI components stateless when possible.

## Backend patterns
- Use layered structure:
  - controller for API layer.
  - service for business rules.
  - repository for persistence.
  - entity and dto for data modeling.
- Keep controllers thin and move logic to services.
- Validate request payloads with Bean Validation.

## API design
- Prefix endpoints with /api.
- Return explicit HTTP status codes.
- Use predictable error payloads with message, code, timestamp.

## Error handling
- Centralize exception mapping with @ControllerAdvice.
- Avoid leaking stack traces to clients.
- Log useful context for diagnosis without exposing secrets.

## PostgreSQL and persistence
- Configure datasource via environment variables.
- Keep schema migrations explicit (Flyway/Liquibase once schema stabilizes).
- Prefer transactional service methods for write operations.

## Agent enforcement
- Agents must read this document before code generation.
- CI checks should fail if lint/build/test fail in any touched app.
