#!/usr/bin/env bash
# What "green" means for the archive: it has no packages to install, so it is the
# linters and every local link and asset resolving the way nginx serves them
# (scripts/known-broken-links.txt lists what was already broken before).
# CI (.github/workflows/ci.yml) and deps-factory both run this.
set -euo pipefail
cd "$(dirname "$0")/.."

# The link checker (ruff: only pyflakes and bugbear, the rules that find bugs),
# the workflows (actionlint, with shellcheck over their run: blocks) and the
# shell scripts, with each tool pinned and fetched by scripts/lint-tool.sh.
git ls-files -z '*.py' | xargs -0 scripts/lint-tool.sh ruff check --no-cache --select F,B
scripts/lint-tool.sh actionlint
git ls-files -z '*.sh' | xargs -0 scripts/lint-tool.sh shellcheck -S warning

python3 scripts/check-links.py site --known scripts/known-broken-links.txt --dir-index \
  thirteen.barcamplondon.org barcamplondon.org www.barcamplondon.org
