#!/usr/bin/env bash
set -euo pipefail

MODEL="${MODEL_THINKER:-/models/llama-70b-instruct-q4_k_m.gguf}"
PORT="${PORT_THINKER:-8003}"
CTX="${CTX_THINKER:-32768}"
THREADS="${THREADS_THINKER:-16}"

exec llama-server \
  -m "$MODEL" \
  --host 127.0.0.1 --port "$PORT" \
  -c "$CTX" \
  --parallel 1 --slots \
  -ngl 999 \
  -fa 1 --no-mmap \
  -t "$THREADS" \
  -b 512 -ub 256 \
  --metrics
