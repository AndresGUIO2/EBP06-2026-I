# Local Development

## Prerequisites
- Node.js 24+
- pnpm 10+
- Java 17+
- Docker with Compose v2

## First setup
1. Copy .env.example to .env and adjust values if needed.
2. Run ./dev-start.sh from repository root.
3. Open:
   - Frontend: http://localhost:3000
   - Backend health: http://localhost:8080/api/health

## Stop services
- Press Ctrl+C in the terminal running dev-start.sh.
- Or run ./dev-stop.sh.

## Local commands
- pnpm dev
- pnpm build
- pnpm lint
- pnpm test
