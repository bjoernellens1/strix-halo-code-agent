#!/usr/bin/env bash
set -euo pipefail

NAME="${1:-opencode}"

# Check if toolbox exists
if toolbox list -c | grep -q "$NAME"; then
    echo "Toolbox '$NAME' already exists."
    echo "If prior installation failed, remove it first: toolbox rm -f $NAME"
else
    echo "Creating Fedora toolbox: $NAME (Fedora 39)"
    # Force a newer Fedora version since F34 is EOL and Opencode doesn't support it
    toolbox create --distro fedora --release 39 "$NAME"
fi

# Install zsh before opencode
toolbox run --container "$NAME" sudo dnf install -y zsh libsecret gnome-keyring

echo "Installing Opencode inside $NAME..."
# Run the official installer
toolbox run --container "$NAME" bash -c "curl -fsSL https://opencode.ai/install | bash"


# Check for OpenRouter API Key
if [ -z "${OPENROUTER_API_KEY:-}" ]; then
    echo "WARNING: OPENROUTER_API_KEY is not set in the current environment."
    echo "If you plan to use OpenRouter, ensure it is exported in your shell configuration."
    echo "Since toolbox uses bash by default, add it to ~/.bashrc even if you use zsh:"
    echo "  echo 'export OPENROUTER_API_KEY=your_key_here' >> ~/.bashrc"
    echo ""
fi

echo "Toolbox '$NAME' setup complete."
echo "To use opencode:"
echo "1. Enter the toolbox: toolbox enter $NAME"
echo "   (Ensure OPENROUTER_API_KEY is available inside; check with 'echo \$OPENROUTER_API_KEY')"
echo "2. Run opencode:    OPENCODE_CONFIG_DIR=\$(pwd)/opencode opencode"
