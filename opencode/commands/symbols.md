---
description: Search for symbols (functions, classes) in the codebase
agent: util
---

Search for symbol:
!`rg -n "$1" .opencode/symbols.txt | head -n 20`
If no matches in index, try live search:
!`rg -n "$1" --glob "!node_modules/**" --glob "!target/**" | head -n 20`
