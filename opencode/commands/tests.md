---
description: Run the project's test suite
agent: util
---

Attempt to detect and run tests:
!`if [ -f "package.json" ]; then npm test; elif [ -f "Makefile" ]; then make test; elif [ -f "cargo.toml" ]; then cargo test; else echo "No standard test command found."; fi`
