# OpenRouter Integration & Standalone Agent Tutorial

This guide provides a comprehensive overview of how to use the OpenRouter integration within the `strix-halo-code-agent` stack. It covers both the integration into the main `opencode` system and the usage of the new standalone `openrouter-agent`.

## Prerequisites

Before proceeding, ensure you have the following:

1.  **OpenRouter API Key**: Sign up at [openrouter.ai](https://openrouter.ai/) and generate an API key.
2.  **Nix Package Manager**: Required for running the standalone agent in a reproducible environment (standard on NixOS).

## 1. OpenRouter in `opencode`

The `opencode` system has been updated to support OpenRouter as a model provider. This allows you to use powerful cloud-based models alongside or instead of local llama.cpp models.

### Configuration

The configuration is located at `opencode/opencode.jsonc`.

#### Provider Setup
We have added `openrouter` to the `enabled_providers` list and configured it with your API key environment variable:

```jsonc
"openrouter": {
    "npm": "@ai-sdk/openai-compatible",
    "name": "OpenRouter",
    "options": {
        "baseURL": "https://openrouter.ai/api/v1",
        "apiKey": "ENV:OPENROUTER_API_KEY", // Make sure this ENV var is set!
        "timeout": 600000
    },
    "models": {
        "minimax_coder": { "name": "Minimax-Coder", "id": "minimax/minimax-m2.5", "tool_call": true, "limit": { "context": 128000, "output": 8192 } },
        "safeguard":     { "name": "Safeguard",     "id": "openai/gpt-oss-safeguard-20b", "tool_call": false, "limit": { "context": 128000, "output": 4096 } }
    }
}
```

#### Agent Configuration
The agents have been updated to use these models:

-   **Build Agent** (`agent.build`): Uses `minimax/minimax-m2.5` for coding tasks.
-   **Research Agent** (`agent.research`): Uses `openai/gpt-oss-safeguard-20b` for background research and web search.

### Usage

To use `opencode` with OpenRouter:

1.  **Export your API Key**:
    ```bash
    export OPENROUTER_API_KEY=sk-or-v1-your-key-here
    ```

2.  **Run Opencode**:
    ```bash
    opencode
    ```

The agents will automatically verify and use the configured OpenRouter models.

---

## 2. Standalone `openrouter-agent`

We have created a modular, standalone agent located in `openrouter-agent/`. This agent is designed to be a lightweight, independent runner for OpenRouter models, useful for testing, quick queries, or building specialized workflows outside the main stack.

### Directory Structure

-   `src/agent.ts`: Core agent logic using `@openrouter/sdk` with event-based streaming.
-   `src/tools.ts`: Tool definitions (Time, Calculator, Web Search).
-   `src/headless.ts`: A CLI entry point to chat with the agent.
-   `flake.nix`: Defines the Nix development environment.

### Setup & Running

1.  **Navigate to the directory**:
    ```bash
    cd openrouter-agent
    ```

2.  **Enter the Nix Environment**:
    This ensures you have the correct Node.js and dependencies.
    ```bash
    nix develop
    ```

3.  **Install Dependencies**:
    (First time only)
    ```bash
    npm install
    ```

4.  **Build the Agent**:
    ```bash
    npm run build
    ```

5.  **Run the Agent**:
    Ensure your API key is set, then start the headless runner:
    ```bash
    export OPENROUTER_API_KEY=sk-or-v1-your-key-here
    npm run start:headless
    ```

### Customization

You can modify `src/headless.ts` to change the model or system instructions:

```typescript
const agent = createAgent({
    apiKey,
    model: 'anthropic/claude-3-opus', // Change model here
    instructions: 'You are a specialized expert in...',
    tools: defaultTools,
});
```

## Troubleshooting

### Build Errors (Zod Version Mismatch)
If you encounter errors related to `Zod` types (e.g., `Type 'ZodObject...' is missing ...`), this is due to a version mismatch between the SDK and the installed Zod version.
**Fix**: We have pinned `zod` to version `3.23.8` in `package.json`. Ensure you run `npm install` to apply this.

### TypeScript Generics
The OpenRouter SDK and `ai-sdk` can be strict about Tool generics. We have used simplified typing in `src/tools.ts` and `src/agent.ts` to ensure compatibility. If you add new tools, follow the pattern in `src/tools.ts` (explicit argument typing, casting schema if necessary).

### Missing API Key
If the agent fails immediately, check that `OPENROUTER_API_KEY` is exported in your current shell session.
