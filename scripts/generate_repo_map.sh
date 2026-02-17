#!/usr/bin/env bash
set -e

# Output files
MAP_FILE=".opencode/repo_map.md"
SYMBOLS_FILE=".opencode/symbols.txt"

mkdir -p .opencode

echo "Generating repo map..."

{
  echo "# Repository Map"
  echo "Generated: $(date)"
  echo ""
  
  echo "## Directory Structure (Depth 4)"
  echo '```'
  # tree is great if installed, otherwise list
  if command -v tree &> /dev/null; then
      tree -L 4 -I "node_modules|target|dist|build|.git|.opencode|.vscode" --dirsfirst
  else
      find . -maxdepth 4 -not -path '*/.*' -print | sort
  fi
  echo '```'
  echo ""

  echo "## Key Files"
  echo '```'
  fd -t f "(README|package\.json|pyproject\.toml|Makefile|Dockerfile|cargo\.toml)" || find . -maxdepth 2 -name "README*" -o -name "package.json"
  echo '```'

} > "$MAP_FILE"

echo "Generating symbols index..."
# Simple regex-based symbol extraction for common languages (Python, JS/TS, Rust, C++)
# This is a "poor man's ctags" to avoid dependency hell
{
    echo "# Symbol Index"
    echo "Format: file:line: code"
    echo ""
    rg -n -t py -t js -t ts -t rust -t cpp -t c \
       "^(class|def|function|fn|struct|interface|type)\s+[a-zA-Z_][a-zA-Z0-9_]*" \
       --glob "!node_modules/**" --glob "!target/**" \
       | head -n 2000 
} > "$SYMBOLS_FILE"

echo "Done. Map saved to $MAP_FILE and $SYMBOLS_FILE"
