#!/usr/bin/env bash
# Link skills from .agents/skills into sibling tool skill dirs.
# Idempotent: re-runs replace stale links pointing at the right source.
#
# Usage:
#   link-skills.sh              # link all skills
#   link-skills.sh <name> ...   # link only named skill(s)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SRC="$ROOT/.agents/skills" # cursor/codex reads from .agents
TARGETS=(".claude/skills")

if [[ ! -d "$SRC" ]]; then
  echo "source missing: $SRC" >&2
  exit 1
fi

if [[ $# -gt 0 ]]; then
  skill_paths=()
  for name in "$@"; do
    p="$SRC/$name"
    if [[ ! -d "$p" ]]; then
      echo "skill not found: $name (expected $p)" >&2
      exit 1
    fi
    skill_paths+=("$p/")
  done
else
  skill_paths=("$SRC"/*/)
fi

linked=0
skipped=0

for target_rel in "${TARGETS[@]}"; do
  target="$ROOT/$target_rel"
  mkdir -p "$target"

  for skill_path in "${skill_paths[@]}"; do
    [[ -d "$skill_path" ]] || continue
    name="$(basename "$skill_path")"
    link="$target/$name"
    rel="../../.agents/skills/$name"

    if [[ -L "$link" ]]; then
      current="$(readlink "$link")"
      if [[ "$current" == "$rel" ]]; then
        skipped=$((skipped+1))
        continue
      fi
      rm "$link"
    elif [[ -e "$link" ]]; then
      echo "skip (not symlink): $target_rel/$name" >&2
      continue
    fi

    ln -s "$rel" "$link"
    echo "linked: $target_rel/$name -> $rel"
    linked=$((linked+1))
  done
done

echo "done. linked=$linked unchanged=$skipped"
