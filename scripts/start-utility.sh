#!/usr/bin/env bash
set -euo pipefail

# MODEL variables are optional overrides now (see below)
PORT="${PORT_UTIL:-8001}"
CTX="${CTX_UTIL:-8192}"
THREADS="${THREADS_UTIL:-16}"

THREADS="${THREADS_UTIL:-16}"
LLAMA_BIN="${LLAMA_SERVER_BIN:-llama-server}"

if ! command -v "$LLAMA_BIN" &> /dev/null; then
    echo "Error: $LLAMA_BIN not found in PATH."
    echo "  -> Are you inside the toolbox? (Run: toolbox enter llama-rocm-7.2)"
    echo "  -> Or set LLAMA_SERVER_BIN to the absolute path."
    exit 1
fi

# Default to HF auto-download if MODEL_UTIL is not set
HF_REPO="${HF_REPO_UTIL:-bartowski/Qwen2.5-7B-Instruct-GGUF}"
HF_FILE="${HF_FILE_UTIL:-Qwen2.5-7B-Instruct-Q4_K_M.gguf}"

# If MODEL_UTIL is set (legacy/local override), use it with -m
# Otherwise use --hf-repo / --hf-file
if [ -n "${MODEL_UTIL:-}" ]; then
  MODEL_ARGS="-m $MODEL_UTIL"
else
  MODEL_ARGS="--hf-repo $HF_REPO --hf-file $HF_FILE"
fi

exec "$LLAMA_BIN" \
  $MODEL_ARGS \
  --host 127.0.0.1 --port "$PORT" \
  -c "$CTX" \
  --parallel 4 --slots \
  -ngl 999 \
  -fa 1 --no-mmap \
  -t "$THREADS" \
  -b 1024 -ub 256 \
  --metrics
