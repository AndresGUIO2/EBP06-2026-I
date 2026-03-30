# PostgreSQL Table Design Skill

## Purpose
Guiar decisiones de modelo y consultas en PostgreSQL para cambios simples, seguros y mantenibles.

## Triggers
- Nuevas tablas/entidades.
- Cambios de esquema (columnas, llaves, indices).
- Dudas de rendimiento en queries o joins.

## Source
- Upstream reference: https://github.com/wshobson/agents/blob/main/plugins/database-design/skills/postgresql/SKILL.md
- Repository constraints: `.agents/skills/design-patterns-backend/SKILL.md`.

## Instructions for agents
1. Definir PK/FK y nullability de forma explicita.
2. Usar tipos correctos para el dominio (`numeric` dinero, `timestamptz` tiempo).
3. Crear indices solo cuando hay acceso real que lo justifique.
4. Preferir cambios backward compatible.
5. Documentar impacto de cada cambio de BD en PR.
6. Mantener los cambios chicos y faciles de revertir.

## Quick start
1. Describir entidad y consultas principales.
2. Definir columnas minimas y restricciones basicas.
3. Verificar si necesita indice (ej: por FK o filtro frecuente).
4. Revisar impacto en endpoints existentes.

## Checklist minimo de esquema
- PK definida.
- FKs necesarias definidas.
- Campos obligatorios con `NOT NULL`.
- Tipo correcto para dinero/fecha.
- Nombre de tablas y columnas en `snake_case`.

## Errores comunes a evitar
- Columnas sin uso real.
- Tipos genericos donde se requiere precision.
- Agregar indices a ciegas.
- Cambios rompientes sin nota de migracion.

## Validation checklist
- Cambio de esquema entendible y reversible.
- Restricciones e indices coherentes con consultas esperadas.
- Tipos alineados al dominio.
- Impacto documentado en el PR.
