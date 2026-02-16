#!/usr/bin/env bash
set -euo pipefail

echo "Checking Utility Agent (8001)..."
curl -s http://127.0.0.1:8001/health >/dev/null && echo "OK" || echo "FAIL"

echo "Checking Coder Agent (8002)..."
curl -s http://127.0.0.1:8002/health >/dev/null && echo "OK" || echo "FAIL"

echo "Checking Thinker Agent (8003)..."
curl -s http://127.0.0.1:8003/health >/dev/null && echo "OK" || echo "FAIL"
