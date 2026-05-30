#!/usr/bin/env bash
# Print Copilot (or other reviewer) feedback: top-level reviews, unresolved threads, inline comments.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/reviewers.sh
source "$SCRIPT_DIR/lib/reviewers.sh"

REVIEWER="${1:-copilot}"
PR="${2:-}"

if [[ -z "${PR}" ]]; then
  PR="$(gh pr view --json number -q .number 2>/dev/null)" || {
    echo "usage: list-pr-feedback.sh [reviewer] [pr-number]" >&2
    echo "  reviewer: copilot (default) or a GitHub login" >&2
    exit 1
  }
fi

repo="$(resolve_pr_repo "$PR")"
owner="${repo%%/*}"
name="${repo##*/}"

if reviewer_is_copilot_alias "$REVIEWER"; then
  display_reviewer="Copilot"
  review_jq_filter="[.reviews[] | select(${JQ_IS_COPILOT_REVIEW_AUTHOR})]"
  thread_jq_filter="select(.isResolved == false) | select(.comments.nodes[0] | ${JQ_IS_COPILOT_GRAPHQL_AUTHOR})"
  inline_jq_filter="[.[] | select(${JQ_IS_COPILOT_INLINE_USER})]"
else
  display_reviewer="$REVIEWER"
  review_jq_filter="[.reviews[] | select(.author.login==\"${REVIEWER}\")]"
  thread_jq_filter="select(.isResolved == false) | select(.comments.nodes[0].author.login==\"${REVIEWER}\")"
  inline_jq_filter="[.[] | select(.user.login==\"${REVIEWER}\")]"
fi

echo "=== Top-level reviews from ${display_reviewer} (PR #${PR} in ${repo}) ==="
gh_pr_view "$PR" --json reviews -q \
  "${review_jq_filter}[] | \"[\(.state)] \(.author.login) \(.submittedAt)\n\(.body)\n---\""

echo ""
echo "=== Unresolved inline threads from ${display_reviewer} ==="
gh api graphql -f query='
query($owner: String!, $name: String!, $number: Int!) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $number) {
      reviewThreads(first: 100) {
        nodes {
          isResolved
          path
          line
          comments(first: 1) {
            nodes {
              author { login }
              body
            }
          }
        }
      }
    }
  }
}' -f owner="${owner}" -f name="${name}" -F number="${PR}" \
  --jq ".data.repository.pullRequest.reviewThreads.nodes[]
    | ${thread_jq_filter}
    | \"[\(.comments.nodes[0].author.login)] \(.path):\(.line // \"general\")\n\(.comments.nodes[0].body)\n---\""

echo ""
echo "=== Inline review comments (REST) from ${display_reviewer} ==="
gh api "repos/${repo}/pulls/${PR}/comments" \
  --jq "${inline_jq_filter}[] | \"[\(.user.login)] \(.path):\(.line // .original_line // \"?\")\n\(.body)\n---\""
