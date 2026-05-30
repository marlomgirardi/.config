#!/usr/bin/env bash
# Block until all PR checks finish. Exits 0 only when every check passes.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/reviewers.sh
source "$SCRIPT_DIR/lib/reviewers.sh"

PR="${1:-}"
INTERVAL="${2:-30}"

if [[ -z "${PR}" ]]; then
  PR="$(gh pr view --json number -q .number 2>/dev/null)" || {
    echo "usage: wait-pr-checks.sh [pr-number] [interval-seconds]" >&2
    exit 1
  }
fi

repo="$(resolve_pr_repo "$PR")"

echo "Watching PR #${PR} checks in ${repo} (interval ${INTERVAL}s)..."
gh_pr_cmd checks "$PR" --watch --interval "${INTERVAL}"
