---
description: Run tests (project-aware)
agent: fixer
---

Detect and run tests in this order if present:
1) make test
2) pytest -q
3) npm test
4) cargo test
5) go test ./...

Show failures + propose minimal fixes.
