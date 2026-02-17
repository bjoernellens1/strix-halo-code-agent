#!/usr/bin/env bash
set -euo pipefail
for p in 8001 8002 8003; do
  echo "== $p =="
  curl -sf "http://127.0.0.1:$p/v1/models" | head -c 400 || exit 1
  echo
done
echo "OK"
