#!/usr/bin/env bash
set -euo pipefail

# MODEL variables are optional overrides now (see below)
PORT="${PORT_CODER:-8002}"
CTX="${CTX_CODER:-32768}"
THREADS="${THREADS_CODER:-16}"

THREADS="${THREADS_CODER:-16}"
LLAMA_BIN="${LLAMA_SERVER_BIN:-llama-server}"

if ! command -v "$LLAMA_BIN" &> /dev/null; then
    echo "Error: $LLAMA_BIN not found in PATH."
    echo "  -> Are you inside the toolbox? (Run: toolbox enter llama-rocm-7.2)"
    echo "  -> Or set LLAMA_SERVER_BIN to the absolute path."
    exit 1
fi

# Default to HF auto-download if MODEL_CODER is not set
HF_REPO="${HF_REPO_CODER:-bartowski/Qwen2.5-Coder-32B-Instruct-GGUF}"
HF_FILE="${HF_FILE_CODER:-Qwen2.5-Coder-32B-Instruct-Q4_K_M.gguf}"

if [ -n "${MODEL_CODER:-}" ]; then
    MODEL_ARGS="-m $MODEL_CODER"
else
    MODEL_ARGS="--hf-repo $HF_REPO --hf-file $HF_FILE"
fi

exec "$LLAMA_BIN" \
  $MODEL_ARGS \
  --host 127.0.0.1 --port "$PORT" \
  -c "$CTX" \
  --parallel 2 --slots \
  -ngl 999 \
  -fa 1 --no-mmap \
  -t "$THREADS" \
  -b 1024 -ub 256 \
  --metrics
