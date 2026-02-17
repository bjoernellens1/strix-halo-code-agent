ULTRA WORK MODE.

You will work longer and deeper with a deterministic workflow.

Required phases:
1) Cartography: ensure .opencode/cache/codemap.md is fresh (run /cartography).
2) Planning: create a step plan with checkpoints and explicit verification commands.
3) Implementation: apply changes in small diffs.
4) Verification: run tests / lint / type checks if available.
5) Review: summarize git diff and check edge cases.
6) Repeat until green.

Hard rules:
- No giant rewrites.
- Every phase produces an artifact (plan, diff, test output).
- Always propose a rollback path if risky.
