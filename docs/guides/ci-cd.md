# CI/CD Strategy

## Branches
- develop: integration and dev deployment branch.
- main: stable branch, CI only for now.

## CI
Workflow: .github/workflows/ci.yml

Triggers:
- Pull requests to develop and main.
- Pushes to main.

Checks:
- pnpm lint
- pnpm test
- pnpm build

## CD for develop
Workflow: .github/workflows/deploy-develop.yml

Trigger:
- Push to develop.

Deploy targets:
- Frontend to Vercel (only when frontend/shared files change).
- Backend to Railway via deploy hook (only when backend/shared files change).

Changed path filters include:
- apps/frontend/**
- apps/backend/**
- packages/**
- package.json
- pnpm-lock.yaml
- pnpm-workspace.yaml
- turbo.json

Required GitHub secrets:
- VERCEL_TOKEN
- VERCEL_ORG_ID
- VERCEL_PROJECT_ID
- RAILWAY_BACKEND_DEPLOY_HOOK

## Production
- Not enabled yet.
- main currently runs CI only.
