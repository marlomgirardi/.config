#!/usr/bin/env bash
# Block until a GitHub reviewer submits a review or leaves inline PR comments.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/reviewers.sh
source "$SCRIPT_DIR/lib/reviewers.sh"

REVIEWER="${1:-copilot}"
PR="${2:-}"
MAX_SECONDS="${3:-1800}"
POLL="${4:-60}"

if [[ -z "${PR}" ]]; then
  PR="$(gh pr view --json number -q .number 2>/dev/null)" || {
    echo "usage: wait-reviewer-review.sh [reviewer] [pr-number] [max-seconds] [poll-seconds]" >&2
    echo "  reviewer: copilot (default) or a GitHub login" >&2
    exit 1
  }
fi

repo="$(resolve_pr_repo "$PR")"
display_reviewer="$REVIEWER"
if reviewer_is_copilot_alias "$REVIEWER"; then
  display_reviewer="Copilot (reviewer: copilot-pull-request-reviewer, inline: Copilot)"
fi

deadline=$(( $(date +%s) + MAX_SECONDS ))

echo "Waiting for ${display_reviewer} on PR #${PR} in ${repo} (max ${MAX_SECONDS}s, poll ${POLL}s)..."

while (( $(date +%s) < deadline )); do
  if reviewer_is_copilot_alias "$REVIEWER"; then
    state="$(gh_pr_view "$PR" --json reviews -q \
      "[.reviews[] | select(${JQ_IS_COPILOT_REVIEW_AUTHOR})] | last | .state // empty" 2>/dev/null || true)"
  else
    state="$(gh_pr_view "$PR" --json reviews -q \
      "[.reviews[] | select(.author.login==\"${REVIEWER}\")] | last | .state // empty" 2>/dev/null || true)"
  fi

  if [[ -n "${state}" && "${state}" != "PENDING" && "${state}" != "null" ]]; then
    echo "Review submitted: state=${state}"
    exit 0
  fi

  if reviewer_is_copilot_alias "$REVIEWER"; then
    comment_count="$(gh api "repos/${repo}/pulls/${PR}/comments" \
      --jq "[.[] | select(${JQ_IS_COPILOT_INLINE_USER})] | length" 2>/dev/null || echo 0)"
  else
    comment_count="$(gh api "repos/${repo}/pulls/${PR}/comments" \
      --jq "[.[] | select(.user.login==\"${REVIEWER}\")] | length" 2>/dev/null || echo 0)"
  fi

  if [[ "${comment_count}" -gt 0 ]]; then
    echo "Found ${comment_count} inline comment(s) from ${display_reviewer}"
    exit 0
  fi

  sleep "${POLL}"
done

echo "Timed out waiting for ${display_reviewer}" >&2
exit 1
