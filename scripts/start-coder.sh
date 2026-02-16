#!/usr/bin/env bash
set -euo pipefail

MODEL="${MODEL_CODER:-/models/qwen3-coder-30b-q4_k_m.gguf}"
PORT="${PORT_CODER:-8002}"
CTX="${CTX_CODER:-32768}"
THREADS="${THREADS_CODER:-16}"

exec llama-server \
  -m "$MODEL" \
  --host 127.0.0.1 --port "$PORT" \
  -c "$CTX" \
  --parallel 2 --slots \
  -ngl 999 \
  -fa 1 --no-mmap \
  -t "$THREADS" \
  -b 1024 -ub 256 \
  --metrics
