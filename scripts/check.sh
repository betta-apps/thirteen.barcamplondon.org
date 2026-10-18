#!/usr/bin/env bash
# What "green" means for the archive: it has no packages to install, so it is
# every local link and asset resolving the way nginx serves them
# (scripts/known-broken-links.txt lists what was already broken before).
# CI (.github/workflows/ci.yml) and deps-factory both run this.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 scripts/check-links.py site --known scripts/known-broken-links.txt --dir-index \
  thirteen.barcamplondon.org barcamplondon.org www.barcamplondon.org
