#!/usr/bin/env bash
set -euo pipefail

MODEL="${MODEL_UTIL:-/models/qwen2.5-7b-instruct-q4_k_m.gguf}"
PORT="${PORT_UTIL:-8001}"
CTX="${CTX_UTIL:-8192}"
THREADS="${THREADS_UTIL:-16}"

exec llama-server \
  -m "$MODEL" \
  --host 127.0.0.1 --port "$PORT" \
  -c "$CTX" \
  --parallel 4 --slots \
  -ngl 999 \
  -fa 1 --no-mmap \
  -t "$THREADS" \
  -b 1024 -ub 256 \
  --metrics
