# .agents

Este directorio contiene la gobernanza agnostica para agentes de desarrollo.

## Estructura
- `skills/registry.md`: registro de skills locales y sus fuentes upstream.
- `skills/design-patterns-frontend/SKILL.md`: patrones base para frontend.
- `skills/design-patterns-backend/SKILL.md`: patrones base para backend.
- `skills/design-patterns/SKILL.md`: indice legacy de compatibilidad.
- `skills/figma-make-handoff/SKILL.md`: handoff de Figma Make a implementacion.

## Regla operativa
- Toda contribucion asistida por agentes debe iniciar leyendo `AGENTS.md`.
- Si el cambio es de frontend, leer primero `design-patterns-frontend`.
- Si el cambio es de backend, leer primero `design-patterns-backend`.
- Si el ticket viene desde Figma Make, aplicar el playbook de `docs/guides/figma-make-handoff.md`.
