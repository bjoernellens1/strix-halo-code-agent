---
description: Quick repo scan (git status + manifests + entrypoints)
agent: explorer
---

!`git status --porcelain=v1`
!`ls -1 README* pyproject.toml package.json Cargo.toml go.mod CMakeLists.txt Makefile 2>/dev/null || true`
!`rg -n "main\\(|if __name__ == '__main__'|create_app\\(|FastAPI\\(|Flask\\(" -S . 2>/dev/null || true`

Return: likely entry points + how to run/tests.
