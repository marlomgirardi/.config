#!/usr/bin/env bash
# Request GitHub Copilot as a PR reviewer (correct bot login).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/reviewers.sh
source "$SCRIPT_DIR/lib/reviewers.sh"

PR="${1:-}"

if [[ -z "${PR}" ]]; then
  PR="$(gh pr view --json number -q .number 2>/dev/null)" || {
    echo "usage: request-copilot-review.sh [pr-number]" >&2
    exit 1
  }
fi

reviewer="$(reviewer_to_requested_login copilot)"
repo="$(resolve_pr_repo "$PR")"

echo "Requesting ${reviewer} on PR #${PR} in ${repo}..."
gh_pr_cmd edit "$PR" --add-reviewer "${reviewer}"
