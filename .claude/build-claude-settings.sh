#!/usr/bin/env bash
set -euo pipefail

dir="$(cd "$(dirname "$0")" && pwd)"
shared_path="$dir/settings.shared.json"
override_path="$dir/settings.override.json"
output_path="$dir/settings.json"

if [ -f "$override_path" ]; then
  jq -s '.[0] * .[1]' \
    "$shared_path" \
    "$override_path" \
    > "$output_path"
else
  cp "$shared_path" "$output_path"
fi