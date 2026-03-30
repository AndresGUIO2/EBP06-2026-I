# Figma Make Handoff Skill

## Purpose
Convert Figma Make output into small and clear frontend tasks for beginner teams.

## Triggers
- UI ticket includes a Figma/Figma Make link or design export.
- Team asks how to start coding from design.

## Source
- Local playbook: `docs/guides/figma-make-handoff.md`
- Repository constraints: `AGENTS.md` and `.agents/skills/design-patterns-frontend/SKILL.md`

## Instructions for agents
1. Start with one screen only.
2. Confirm 3 states: loading, success, error.
3. Create a short task list with small steps.
4. Prefer simple components over complex abstractions.
5. In PR notes, include:
   - design link
   - one desktop screenshot
   - one mobile screenshot

## Quick start
1. Abrir link del diseno.
2. Elegir pantalla v1.
3. Listar componentes minimos.
4. Implementar primero funcionalidad, luego detalle visual.
5. Adjuntar evidencia en PR.

## Formato de salida sugerido
- Pantalla objetivo:
- Componentes:
- Estados:
- Tareas (3-5):
- Evidencia para PR:

## Validation checklist
- Handoff is clear enough for a junior developer to execute.
- Required states are listed.
- PR includes design evidence.
