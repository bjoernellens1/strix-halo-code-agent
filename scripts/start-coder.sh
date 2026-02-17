#!/usr/bin/env bash
set -euo pipefail

# Load .env if present
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ -f "$REPO_ROOT/.env" ]]; then
  source "$REPO_ROOT/.env"
fi

MODEL="${MODEL_CODER:?set MODEL_CODER}"
PORT="${PORT_CODER:-8002}"
CTX="${CTX_CODER:-32768}"
THREADS="${THREADS_CODER:-16}"

EXTRA_ARGS=""
if [[ -n "${HF_TOKEN:-}" ]]; then
  EXTRA_ARGS="--hf-token $HF_TOKEN"
fi

if [[ "$MODEL" == -* ]]; then
  exec llama-server $MODEL $EXTRA_ARGS \
    --host 127.0.0.1 --port "$PORT" \
    -c "$CTX" \
    --parallel 2 --slots \
    -ngl 999 \
    -fa 1 --no-mmap \
    -t "$THREADS" \
    -b 1024 -ub 256 \
    --metrics
else
  exec llama-server $EXTRA_ARGS \
    -m "$MODEL" \
    --host 127.0.0.1 --port "$PORT" \
    -c "$CTX" \
    --parallel 2 --slots \
    -ngl 999 \
    -fa 1 --no-mmap \
    -t "$THREADS" \
    -b 1024 -ub 256 \
    --metrics
fi
