#!/usr/bin/env bash
set -euo pipefail

git submodule foreach --quiet 'printf "%s %s\n" "$name" "$(git rev-parse HEAD)"'