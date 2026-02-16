#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_DIR="$DIR/../mcp"

echo "Stopping Archon in $MCP_DIR..."
cd "$MCP_DIR"

if command -v docker &> /dev/null && docker compose version &> /dev/null; then
    docker compose down
elif command -v docker-compose &> /dev/null; then
    docker-compose down
elif command -v podman-compose &> /dev/null; then
    podman-compose down
else
    echo "Error: No docker-compose compatible tool found!"
    exit 1
fi

echo "Archon stopped."
