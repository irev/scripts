#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/gitea"
cd "$BASE_DIR"

echo "Pulling latest Gitea image..."
docker compose pull

echo "Recreating container..."
docker compose up -d

echo "Current status:"
docker compose ps
