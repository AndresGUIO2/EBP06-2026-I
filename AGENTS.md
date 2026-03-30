# AGENTS

This repository is agent-agnostic and supports Claude Code, Codex, Copilot, and Antigravity.

## Source of truth order
1. This file.
2. Frontend Design Patterns Skill in .agents/skills/design-patterns-frontend/SKILL.md.
3. Backend Design Patterns Skill in .agents/skills/design-patterns-backend/SKILL.md.
4. Figma Make Handoff Skill in .agents/skills/figma-make-handoff/SKILL.md (for UI tickets from design).
5. Architecture patterns in docs/architecture/design-patterns.md.
6. Skill registry in .agents/skills/registry.md.
7. Local app docs inside apps/frontend and apps/backend.

## Branch policy
- Feature branches target develop.
- develop is the integration branch and triggers dev deployment.
- main remains stable; production deployment is intentionally disabled for now.

## Commit policy
- Use atomic commits: one logical change per commit.
- Use Conventional Commits in Spanish with format: tipo(alcance): descripcion.
- Recommended types: feat, fix, docs, test, refactor, chore.
- Write messages in imperative Spanish and keep the subject concise.
- Do not mix unrelated changes (for example, feature + refactor + docs in the same commit).

## Mandatory rules for all agents
- Read the applicable design-patterns skill before generating code.
- Frontend work: read `.agents/skills/design-patterns-frontend/SKILL.md`. Understand that the frontend uses React, Vite, and Tailwind CSS v4.
- Backend work: read `.agents/skills/design-patterns-backend/SKILL.md`.
- Figma-originated UI work: read `.agents/skills/figma-make-handoff/SKILL.md` and `docs/guides/figma-make-handoff.md` before implementation.
- Keep changes scoped to the request and avoid broad refactors.
- Add or update tests when behavior changes.
- Never commit secrets or real credentials.
- Prefer environment variables over hard-coded values.

## Review checklist for agent-generated PRs
- Monorepo scripts run from repository root.
- Frontend and backend both pass build checks.
- Frontend tests are real assertions (no placeholder commands).
- API changes are documented.
- Error handling follows backend patterns.
- Database changes are backward compatible.
- For UI tickets from Figma, attach the link and one desktop/mobile screenshot pair.

## CI/CD behavior
- Pull requests to develop/main run tests.
- Pushes to develop/main run the same test workflow.
- A successful push test run on develop triggers a Vercel preview deployment for the frontend from GitHub Actions.
- A successful push test run on main triggers a Vercel production deployment for the frontend from GitHub Actions.
- Backend dev deployment uses Railway Watch with Wait for CI instead of a deploy hook.

## Required secrets
- VERCEL_TOKEN
- VERCEL_ORG_ID
- VERCEL_PROJECT_ID
