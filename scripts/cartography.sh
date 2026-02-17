#!/usr/bin/env bash
set -euo pipefail

OUT_DIR=".opencode/cache"
mkdir -p "$OUT_DIR"

HASH_FILE="$OUT_DIR/filehashes.json"
CODEMAP="$OUT_DIR/codemap.md"

# compute hash of each tracked file (git ls-files)
tmp="$(mktemp)"
git ls-files -z | xargs -0 -I{} sha1sum "{}" >> "$tmp"

# if same as last run, skip
if [[ -f "$HASH_FILE" ]]; then
  old_sum="$(sha1sum "$HASH_FILE" | awk '{print $1}')"
  new_sum="$(sha1sum "$tmp" | awk '{print $1}')"
  if [[ "$old_sum" == "$new_sum" ]]; then
    echo "Cartography: no changes, keeping codemap."
    rm -f "$tmp"
    exit 0
  fi
fi

# write hashes
cp "$tmp" "$HASH_FILE"
rm -f "$tmp"

# build codemap
{
  echo "# Code Map"
  echo
  echo "## Repo tree (depth 4)"
  echo '```'
  command -v tree >/dev/null && tree -L 4 -a -I ".git|.opencode|node_modules|dist|build|__pycache__" || find . -maxdepth 4 -type d
  echo '```'
  echo
  echo "## Key manifests"
  echo '```'
  ls -1 README* pyproject.toml poetry.lock requirements*.txt package.json pnpm-lock.yaml Cargo.toml go.mod CMakeLists.txt Makefile 2>/dev/null || true
  echo '```'
  echo
  echo "## Top-level packages/modules"
  echo '```'
  ls -1 2>/dev/null
  echo '```'
  echo
  echo "## Git status"
  echo '```'
  git status --porcelain=v1
  echo '```'
} > "$CODEMAP"

echo "Cartography: wrote $CODEMAP"
