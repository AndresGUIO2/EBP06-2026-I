#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${ROOT_DIR}"
docker compose down
pkill -f "gradlew bootRun" >/dev/null 2>&1 || true
pkill -f "vite --host" >/dev/null 2>&1 || true

echo "Local development services stopped."
