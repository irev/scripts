#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/gitea"
cd "$BASE_DIR"

IP=$(hostname -I | awk '{print $1}')
STATUS=$(docker inspect -f '{{.State.Status}}' gitea 2>/dev/null || true)
UPTIME=$(docker inspect -f '{{.State.StartedAt}}' gitea 2>/dev/null || true)
DISK=$(df -h "$BASE_DIR" | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')

echo "Gitea Status"
echo "============"
echo "Container : ${STATUS:-not found}"
echo "Web       : http://${IP:-<VM-IP>}:3000"
echo "SSH       : ${IP:-<VM-IP>}:2222"
echo "Disk      : ${DISK:-unknown}"
echo "Data      : $BASE_DIR/data"
echo "Started   : ${UPTIME:-unknown}"
echo

docker compose ps
