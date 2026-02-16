#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$DIR/start-utility.sh" & P1=$!
"$DIR/start-coder.sh"   & P2=$!
"$DIR/start-thinker.sh" & P3=$!

trap 'kill $P1 $P2 $P3 2>/dev/null || true' EXIT
wait
