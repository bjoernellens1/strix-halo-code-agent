#!/usr/bin/env bash
set -euo pipefail

# MODEL variables are optional overrides now (see below)
PORT="${PORT_THINKER:-8003}"
CTX="${CTX_THINKER:-32768}"
THREADS="${THREADS_THINKER:-16}"

THREADS="${THREADS_THINKER:-16}"
LLAMA_BIN="${LLAMA_SERVER_BIN:-llama-server}"

if ! command -v "$LLAMA_BIN" &> /dev/null; then
    echo "Error: $LLAMA_BIN not found in PATH."
    echo "Please set LLAMA_SERVER_BIN to the absolute path of the llama-server binary."
    exit 1
fi

# Default to HF auto-download if MODEL_THINKER is not set
HF_REPO="${HF_REPO_THINKER:-bartowski/Meta-Llama-3.1-70B-Instruct-GGUF}"
HF_FILE="${HF_FILE_THINKER:-Meta-Llama-3.1-70B-Instruct-Q4_K_M.gguf}"

if [ -n "${MODEL_THINKER:-}" ]; then
    MODEL_ARGS="-m $MODEL_THINKER"
else
    MODEL_ARGS="--hf-repo $HF_REPO --hf-file $HF_FILE"
fi

exec "$LLAMA_BIN" \
  $MODEL_ARGS \
  --host 127.0.0.1 --port "$PORT" \
  -c "$CTX" \
  --parallel 1 --slots \
  -ngl 999 \
  -fa 1 --no-mmap \
  -t "$THREADS" \
  -b 512 -ub 256 \
  --metrics
