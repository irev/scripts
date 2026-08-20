#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/gitea"
COMPOSE_URL="https://raw.githubusercontent.com/irev/scripts/refs/heads/main/compose.yaml"

if [[ ${EUID} -ne 0 ]]; then
  echo "Run with sudo: sudo bash gitea/install.sh" >&2
  exit 1
fi

command -v docker >/dev/null 2>&1 || { echo "Docker is not installed." >&2; exit 1; }
docker compose version >/dev/null 2>&1 || { echo "Docker Compose v2 is not available." >&2; exit 1; }

mkdir -p "$BASE_DIR"
curl -fsSL "$COMPOSE_URL" -o "$BASE_DIR/compose.yaml"

cd "$BASE_DIR"
docker compose pull
docker compose up -d

echo
Docker_IP=$(hostname -I | awk '{print $1}')
echo "Gitea started."
echo "Web: http://${Docker_IP:-<VM-IP>}:3000"
echo "SSH: ${Docker_IP:-<VM-IP>}:2222"
docker compose ps
