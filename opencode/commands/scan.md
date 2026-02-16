---
description: Quick repo scan (tree, git status, key files)
agent: util
---

Repo overview:
!`pwd`
!`git status --porcelain=v1`
!`git rev-parse --abbrev-ref HEAD`
!`ls -la`
!`find . -maxdepth 2 -type f -name "README*" -o -name "pyproject.toml" -o -name "package.json" -o -name "Cargo.toml" -o -name "Makefile"`
Summarize the project structure and identify likely entry points.
