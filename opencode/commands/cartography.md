---
description: Generate/refresh codemap cache (Cartography)
agent: explorer
---

Run:
!`bash scripts/cartography.sh`

Then print:
!`ls -la .opencode/cache`
!`sed -n '1,120p' .opencode/cache/codemap.md`

Summarize the codemap in 10 lines.
