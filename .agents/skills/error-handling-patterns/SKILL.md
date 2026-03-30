# Error Handling Patterns Skill

## Purpose
Estandarizar manejo de errores en `apps/backend` para que las APIs respondan de forma clara y consistente.

## Triggers
- Nuevos endpoints o servicios.
- Cambios en validaciones, excepciones o payload de error.
- PRs donde haya reglas de negocio y posibles fallos funcionales.

## Source
- Upstream reference: https://github.com/wshobson/agents/blob/main/plugins/developer-essentials/skills/error-handling-patterns/SKILL.md
- Repository constraints: `.agents/skills/design-patterns-backend/SKILL.md`.

## Instructions for agents
1. Mantener controllers delgados; logica en service.
2. Mapear errores conocidos a status HTTP explicitos.
3. Centralizar excepciones con un handler unico.
4. No exponer stacktrace al cliente.
5. Loggear contexto util sin filtrar secretos.
6. Probar flujo feliz y flujo de error cuando cambie comportamiento.

## Quick start
1. Definir errores esperados del caso de uso.
2. Asignar status para cada error.
3. Implementar/ajustar `@ControllerAdvice`.
4. Verificar respuesta de error estable con test.

## Plantilla de payload de error (orientativa)
- `message`: mensaje breve para cliente
- `code`: identificador interno de error
- `timestamp`: fecha/hora del error

## Errores comunes a evitar
- `try/catch` duplicado en cada controller.
- Mensajes tecnicos confusos para frontend.
- Status `500` para errores de negocio previsibles.

## Validation checklist
- Payload de error consistente entre endpoints.
- Status code correcto segun el tipo de fallo.
- Sin informacion sensible en respuesta/logs.
- Tests cubren fallos esperados.
