#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_DIR="$DIR/../mcp"

# Ensure env file exists
if [ ! -f "$MCP_DIR/archon.env" ]; then
    echo "Warning: $MCP_DIR/archon.env not found. Copying from example..."
    cp "$MCP_DIR/archon.env.example" "$MCP_DIR/archon.env"
    echo "NOTE: Please edit $MCP_DIR/archon.env with your actual API keys!"
fi

echo "Starting Archon in $MCP_DIR..."
cd "$MCP_DIR"

# Try docker compose, then docker-compose, then podman-compose
# Try docker compose, then docker-compose, then podman-compose, then podman compose
if command -v docker &> /dev/null && docker compose version &> /dev/null; then
    docker compose up -d
elif command -v docker-compose &> /dev/null; then
    docker-compose up -d
elif command -v podman-compose &> /dev/null; then
    podman-compose up -d
elif command -v podman &> /dev/null && podman compose version &> /dev/null; then
    podman compose up -d
else
    echo "Error: No docker-compose compatible tool found!"
    exit 1
fi

echo "Archon started on port 8181."
