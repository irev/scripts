#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/gitea"
BACKUP_DIR="/opt/backups/gitea"
STAMP=$(date +%Y%m%d-%H%M%S)
ARCHIVE="$BACKUP_DIR/gitea-$STAMP.tar.gz"

if [[ ${EUID} -ne 0 ]]; then
  echo "Run with sudo: sudo bash gitea/backup.sh" >&2
  exit 1
fi

mkdir -p "$BACKUP_DIR"
cd "$BASE_DIR"

echo "Stopping Gitea for consistent SQLite backup..."
docker compose stop gitea
trap 'cd "$BASE_DIR" && docker compose start gitea >/dev/null 2>&1 || true' EXIT

tar -czf "$ARCHIVE" compose.yaml data

cd "$BASE_DIR"
docker compose start gitea
trap - EXIT

echo "Backup created: $ARCHIVE"
ls -lh "$ARCHIVE"
