#!/usr/bin/env bash
set -euo pipefail

NAME="${1:-llama-rocm-7.2}"

toolbox create "$NAME" \
  --image docker.io/kyuz0/amd-strix-halo-toolboxes:rocm-7.2 \
  -- --device /dev/dri --device /dev/kfd \
  --group-add video --group-add render --group-add sudo \
  --security-opt seccomp=unconfined

echo "Toolbox created: $NAME"
echo "Enter: toolbox enter $NAME"
