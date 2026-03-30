#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${ROOT_DIR}/.logs"
BACKEND_LOG="${LOG_DIR}/backend.log"
FRONTEND_LOG="${LOG_DIR}/frontend.log"

mkdir -p "${LOG_DIR}"

if [[ -f "${ROOT_DIR}/.env" ]]; then
  # shellcheck disable=SC1091
  source "${ROOT_DIR}/.env"
fi

check_cmd() {
  local cmd="$1"
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Missing required command: ${cmd}" >&2
    exit 1
  fi
}

check_cmd docker
check_cmd pnpm
check_cmd java

POSTGRES_PORT="${POSTGRES_PORT:-5432}"
POSTGRES_DB="${POSTGRES_DB:-ebp06}"

if ! docker info >/dev/null 2>&1; then
  echo "Docker daemon is not running." >&2
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "docker compose is required (Compose v2 plugin)." >&2
  exit 1
fi

echo "Installing workspace dependencies..."
(cd "${ROOT_DIR}" && pnpm install)

echo "Starting PostgreSQL..."
if ! (cd "${ROOT_DIR}" && docker compose up -d db); then
  echo "Failed to start PostgreSQL container." >&2
  echo "If port ${POSTGRES_PORT} is busy, set POSTGRES_PORT in .env and retry." >&2
  exit 1
fi

echo "Waiting for PostgreSQL healthcheck..."
for _ in {1..60}; do
  status="$(docker inspect --format='{{.State.Health.Status}}' ebp06_db 2>/dev/null || true)"
  if [[ "${status}" == "healthy" ]]; then
    break
  fi
  sleep 2
done

status="$(docker inspect --format='{{.State.Health.Status}}' ebp06_db 2>/dev/null || true)"
if [[ "${status}" != "healthy" ]]; then
  echo "PostgreSQL did not become healthy in time." >&2
  exit 1
fi

cleanup() {
  echo
  echo "Stopping local development services..."

  if [[ -n "${BACKEND_PID:-}" ]] && kill -0 "${BACKEND_PID}" 2>/dev/null; then
    kill "${BACKEND_PID}" || true
  fi

  if [[ -n "${FRONTEND_PID:-}" ]] && kill -0 "${FRONTEND_PID}" 2>/dev/null; then
    kill "${FRONTEND_PID}" || true
  fi

  (cd "${ROOT_DIR}" && docker compose down) || true
}

trap cleanup EXIT INT TERM

echo "Starting backend on :${SERVER_PORT:-8080}..."
(
  cd "${ROOT_DIR}/apps/backend"
  SERVER_PORT="${SERVER_PORT:-8080}" \
  SPRING_DATASOURCE_URL="${SPRING_DATASOURCE_URL:-jdbc:postgresql://localhost:${POSTGRES_PORT}/${POSTGRES_DB}}" \
  SPRING_DATASOURCE_USERNAME="${SPRING_DATASOURCE_USERNAME:-admin}" \
  SPRING_DATASOURCE_PASSWORD="${SPRING_DATASOURCE_PASSWORD:-admin}" \
  SPRING_JPA_HIBERNATE_DDL_AUTO="${SPRING_JPA_HIBERNATE_DDL_AUTO:-update}" \
  CORS_ALLOWED_ORIGIN="${CORS_ALLOWED_ORIGIN:-http://localhost:${VITE_DEV_PORT:-3000}}" \
  ./gradlew bootRun
) >"${BACKEND_LOG}" 2>&1 &
BACKEND_PID=$!

echo "Starting frontend on :${VITE_DEV_PORT:-3000}..."
(
  cd "${ROOT_DIR}/apps/frontend"
  VITE_API_BASE_URL="${VITE_API_BASE_URL:-http://localhost:${SERVER_PORT:-8080}}" \
  VITE_DEV_PORT="${VITE_DEV_PORT:-3000}" \
  pnpm dev
) >"${FRONTEND_LOG}" 2>&1 &
FRONTEND_PID=$!

sleep 4

if ! kill -0 "${BACKEND_PID}" 2>/dev/null; then
  echo "Backend process failed during startup. Check log: ${BACKEND_LOG}" >&2
  tail -n 40 "${BACKEND_LOG}" >&2 || true
  exit 1
fi

if ! kill -0 "${FRONTEND_PID}" 2>/dev/null; then
  echo "Frontend process failed during startup. Check log: ${FRONTEND_LOG}" >&2
  tail -n 40 "${FRONTEND_LOG}" >&2 || true
  exit 1
fi

echo "Services started."
echo "- Backend log:  ${BACKEND_LOG}"
echo "- Frontend log: ${FRONTEND_LOG}"
echo "- Frontend URL:  http://localhost:${VITE_DEV_PORT:-3000}"
echo "- Backend URL:   http://localhost:${SERVER_PORT:-8080}"
echo
echo "Press Ctrl+C to stop all services."

wait "${BACKEND_PID}" "${FRONTEND_PID}"
