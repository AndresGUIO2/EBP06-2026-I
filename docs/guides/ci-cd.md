# CI/CD Strategy

## Branches
- develop: integration and dev deployment branch.
- main: stable branch, CI only for now.

## CI
Workflow: .github/workflows/ci.yml

Triggers:
- Pull requests to develop and main.
- Pushes to develop and main.

Checks:
- pnpm test

## Dev deploys
- Frontend deployment is handled by `.github/workflows/deploy-frontend.yml`.
- The frontend deploy runs only after the `Tests` workflow finishes successfully for a push.
- Pushes to `develop` deploy the frontend to the Vercel `preview` environment.
- Pushes to `main` deploy the frontend to the Vercel `production` environment.
- Backend deployment is handled by Railway Watch with `Wait for CI` enabled instead of a deploy hook.

Required GitHub secrets for current workflows:
- VERCEL_TOKEN
- VERCEL_ORG_ID
- VERCEL_PROJECT_ID

## Production
- Frontend production deployments are triggered from `main` after the `Tests` workflow succeeds.
- Backend production deployment strategy is still defined outside GitHub Actions.
