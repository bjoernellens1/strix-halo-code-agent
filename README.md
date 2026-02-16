# opencode-strix-stack

Local AI coding agent stack for AMD Strix Halo:
- llama.cpp servers (ROCm 7.2 toolbox)
- OpenCode config with Thinker/Coder/Utility
- Ultra Work Mode
- MCP + memory (optional)

## Prereqs
- Fedora toolbox/distrobox
- kyuz0 Strix Halo llama.cpp toolbox image `rocm-7.2`

## 1) Create & enter toolbox
```bash
./scripts/toolbox-create.sh llama-rocm-7.2
toolbox enter llama-rocm-7.2
```

## 2) Start model servers (inside toolbox)

Set paths to GGUF files (or mount them into /models), then:

```bash
export MODEL_UTIL=/models/qwen2.5-7b-instruct-q4_k_m.gguf
export MODEL_CODER=/models/qwen3-coder-30b-q4_k_m.gguf
export MODEL_THINKER=/models/llama-70b-instruct-q4_k_m.gguf
./scripts/start-all.sh
```

## 3) Run OpenCode (host or toolbox)

Point OpenCode at `opencode/opencode.jsonc`:

```bash
OPENCODE_CONFIG_DIR=$(pwd)/opencode opencode
```

## 4) Usage

* Tab between agents: build / plan / ultra
* Run commands: `/scan`, `/tests`, `/review`, `/ultra`
