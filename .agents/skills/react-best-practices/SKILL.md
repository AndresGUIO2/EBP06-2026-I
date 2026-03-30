# React Best Practices Skill

## Purpose
Aplicar practicas de React que mantengan `apps/frontend` simple, estable y facil de probar.

## Triggers
- Nuevos componentes o hooks.
- Refactors de estado, efectos o consumo de API.
- Revisiones donde puede haber regresion de rendimiento o legibilidad.

## Source
- Upstream reference: https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices
- Repository constraints: `.agents/skills/design-patterns-frontend/SKILL.md`.

## Instructions for agents
1. Mantene estado minimo y local cuando sea posible.
2. Evita duplicar datos en estado si se pueden derivar.
3. Usa `useEffect` solo para sincronizar con algo externo.
4. Centraliza fetch en hooks/funciones claras, no disperso en varios componentes.
5. Componentes pequenos: una responsabilidad por componente.
6. Cada flujo async debe contemplar loading y error.

## Quick start
1. Escribir primero el flujo feliz.
2. Agregar loading y error.
3. Extraer logica repetida a hook.
4. Agregar prueba minima del flujo.

## Errores comunes a evitar
- `useEffect` para logica que puede ir en render.
- Mucho estado para datos derivados.
- Componente gigante con UI + fetch + transformaciones mezcladas.
- Manejo de errores ausente.

## Salida esperada
- Codigo React facil de leer para semilleros/juniors.
- Estado y efectos controlados.
- Pruebas minimas para rutas criticas.

## Validation checklist
- Estado/efectos sin complejidad innecesaria.
- Fetch centralizado y testeable.
- Render estable sin loops o rerenders evitables.
- Tests de estados async principales.
