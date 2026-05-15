#!/usr/bin/env bash
# Remove symlinks in sibling tool skill dirs whose target no longer exists
# (e.g. skill deleted from .agents/skills).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TARGETS=(".claude/skills" ".codex/skills" ".copilot/skills" ".cursor/skills")

removed=0

for target_rel in "${TARGETS[@]}"; do
  target="$ROOT/$target_rel"
  [[ -d "$target" ]] || continue

  for link in "$target"/*; do
    [[ -L "$link" ]] || continue
    # broken symlink: -e tests resolved target
    if [[ ! -e "$link" ]]; then
      # only nuke links that point into .agents/skills
      dest="$(readlink "$link")"
      if [[ "$dest" == *".agents/skills/"* ]]; then
        rm "$link"
        echo "removed: $target_rel/$(basename "$link") (was -> $dest)"
        removed=$((removed+1))
      fi
    fi
  done
done

echo "done. removed=$removed"
