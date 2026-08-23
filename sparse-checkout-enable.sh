#!/usr/bin/env bash
set -euo pipefail

git submodule foreach 'git sparse-checkout init --cone && git sparse-checkout set .github cpp java javascript testdata'
