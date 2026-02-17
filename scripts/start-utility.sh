#!/usr/bin/env bash
set -euo pipefail

# Load .env if present
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ -f "$REPO_ROOT/.env" ]]; then
  source "$REPO_ROOT/.env"
fi

MODEL="${MODEL_UTIL:?set MODEL_UTIL}"
PORT="${PORT_UTIL:-8001}"
CTX="${CTX_UTIL:-8192}"
THREADS="${THREADS_UTIL:-16}"

# Check if model is a file or a flag (like -hf)
EXTRA_ARGS=""
if [[ -n "${HF_TOKEN:-}" ]]; then
  EXTRA_ARGS="--hf-token $HF_TOKEN"
fi

if [[ "$MODEL" == -* ]]; then
  # It's a flag, assume it contains args like "-hf repo:file", so NO quoting to allow word splitting
  # This is necessary because llama-server expects "-hf" and "repo:file" as separate args
  exec llama-server $MODEL $EXTRA_ARGS \
    --host 127.0.0.1 --port "$PORT" \
    -c "$CTX" \
    --parallel 4 --slots \
    -ngl 999 \
    -fa 1 --no-mmap \
    -t "$THREADS" \
    -b 1024 -ub 256 \
    --metrics
else
  # It's a file path, safely quote it and use -m
  exec llama-server $EXTRA_ARGS \
    -m "$MODEL" \
    --host 127.0.0.1 --port "$PORT" \
    -c "$CTX" \
    --parallel 4 --slots \
    -ngl 999 \
    -fa 1 --no-mmap \
    -t "$THREADS" \
    -b 1024 -ub 256 \
    --metrics
fi
