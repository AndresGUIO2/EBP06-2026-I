# Frontend Design Skill

## Purpose
Guiar implementaciones de UI en `apps/frontend` con buena estructura, estilo consistente y complejidad adecuada para el equipo.

## Triggers
- Peticiones para crear o mejorar pantallas/componentes en React.
- Tickets de look and feel, jerarquia visual o responsive.
- Trabajo que parte de mockups/Figma y debe bajar a codigo.

## Source
- Upstream reference: https://github.com/anthropics/claude-code/blob/main/plugins/frontend-design/skills/frontend-design/SKILL.md
- Repository constraints: `AGENTS.md` and `.agents/skills/design-patterns-frontend/SKILL.md`.

## Instructions for agents
1. Define una direccion visual clara antes de codificar.
2. Implementa con React + Vite + Tailwind v4 siguiendo patrones del repo.
3. Usa estilos reutilizables (variables/tokens), no valores sueltos repetidos.
4. Cubre estados de UI: loading, success y error como minimo.
5. Mantene accesibilidad basica: jerarquia semantica, contraste y foco visible.
6. Si el diseno es complejo, prioriza una v1 simple y funcional primero.

## Quick start
1. Identificar pantalla objetivo y objetivo de usuario.
2. Dividir en componentes pequenos (presentacion + logica).
3. Implementar primero estructura, despues estilos y microajustes.
4. Verificar mobile/desktop y estados minimos.

## Entrada minima esperada
- Pantalla o componente objetivo.
- Fuente de verdad visual (Figma, imagen, o descripcion).
- Comportamiento minimo esperado (ej: mostrar datos y errores).

## Salida esperada
- Componentes claros y legibles.
- Estilos consistentes con el repositorio.
- Estados de UI implementados.
- Codigo facil de mantener por estudiantes.

## Validation checklist
- UI consistente, sin estilos improvisados.
- Componentes pequenos y mantenibles.
- Estados minimos y responsive cubiertos.
- URLs/API via variables `VITE_`, sin secretos hardcodeados.
