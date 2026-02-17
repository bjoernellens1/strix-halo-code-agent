# opencode-strix-local-pantheon

Code-agent-friendly local stack for AMD Strix Halo (ROCm 7.2).

## Goal
One command starts:
1. 3 llama.cpp OpenAI-compatible servers (Utility/Coder/Thinker)
2. OpenCode with an “oh-my-opencode-slim”-style agent pantheon
3. Cartography (codemap caching) + optional local memory

## Setup

1. **Create Toolbox**:
   ```bash
   make toolbox
   ```

2. **Configure Models**:
   Copy `.env.example` to `.env` and set your absolute GGUF paths.
   ```bash
   cp .env.example .env
   source .env
   ```

3. **Start Servers**:
   ```bash
   # Enter the toolbox
   toolbox enter llama-rocm-7.2

   # Inside toolbox:
   source .env
   ./scripts/start-all.sh
   ```

4. **Verify**:
   In another terminal:
   ```bash
   make health
   ```

5. **Run Agent**:
   ```bash
   make opencode
   ```

## Model Roles

| Role | Model | Ctx | Port | Description |
|---|---|---|---|---|
| **Utility** | Qwen 7B / Llama 8B | 8k | 8001 | Fast scan, summaries, cartography |
| **Coder** | Qwen3 Coder 30B | 32k | 8002 | Implementation, large edits |
| **Thinker** | GLM-4.7 23B | 32k | 8003 | Orchestration, planning, review |

## Key Features

- **Pantheon Agents**: Orchestrator delegates to Explorer, Librarian, Fixer.
- **Cartography**: `.opencode/cache/codemap.md` caches repo structure to save tokens.
- **Ultra Mode**: Deterministic plan -> implement -> verify loop.
- **Local Only**: No cloud dependencies.
