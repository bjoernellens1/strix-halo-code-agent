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

By default, scripts will **automatically download** optimized GGUF models from HuggingFace (specifically `bartowski`'s `Q4_K_M` quantizations):
- **Utility**: `bartowski/Qwen2.5-7B-Instruct-GGUF`
- **Coder**: `bartowski/Qwen2.5-Coder-32B-Instruct-GGUF`
- **Thinker**: `bartowski/Meta-Llama-3.1-70B-Instruct-GGUF`

Just run:
```bash
./scripts/start-all.sh
```

### Optional: Use local models
If you already have models, set the environment variables to point to them:
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

## 5) OpenRouter Integration

To use cloud models via OpenRouter:

1.  Export your API key:
    ```bash
    export OPENROUTER_API_KEY=sk-or-v1-...
    ```
2.  Run `opencode` (it will use the configured OpenRouter models).

### Standalone Agent

A standalone agent is available in `openrouter-agent/`:
```bash
cd openrouter-agent
nix develop
npm run start:headless
```

See [docs/openrouter_tutorial.md](docs/openrouter_tutorial.md) for details.
