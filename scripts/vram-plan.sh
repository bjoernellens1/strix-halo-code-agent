#!/usr/bin/env bash
set -euo pipefail

MODEL="${1:?usage: vram-plan.sh /path/to/model.gguf}"
CTX="${2:-32768}"

gguf-vram-estimator.py "$MODEL" --contexts "$CTX"
