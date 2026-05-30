#!/usr/bin/env bash
# Shared GitHub reviewer identity helpers for work-on scripts.
#
# Copilot PR review uses multiple logins on GitHub:
#   - copilot-pull-request-reviewer  → requested reviewer + top-level PR reviews (gh pr view)
#   - Copilot                        → inline pull request review comments (REST user.login)
#   - copilot-pull-request-reviewer  → GraphQL review thread authors (same as reviewer login)

readonly COPILOT_REQUESTED_REVIEWER="copilot-pull-request-reviewer"

readonly JQ_IS_COPILOT_REVIEW_AUTHOR='
  .author.login == "Copilot"
  or .author.login == "copilot-pull-request-reviewer"
  or (.author.login | test("^copilot-pull-request-reviewer"))
'

readonly JQ_IS_COPILOT_INLINE_USER='
  .user.login == "Copilot"
  or .user.login == "copilot-pull-request-reviewer"
  or (.user.login | test("^copilot-pull-request-reviewer"))
'

readonly JQ_IS_COPILOT_GRAPHQL_AUTHOR='
  .author.login == "Copilot"
  or .author.login == "copilot-pull-request-reviewer"
  or (.author.login | test("^copilot-pull-request-reviewer"))
'

reviewer_is_copilot_alias() {
  local reviewer
  reviewer="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
  [[ "$reviewer" == "copilot" || "$reviewer" == "$COPILOT_REQUESTED_REVIEWER" ]]
}

reviewer_to_requested_login() {
  local reviewer="$1"
  if reviewer_is_copilot_alias "$reviewer"; then
    echo "$COPILOT_REQUESTED_REVIEWER"
  else
    echo "$reviewer"
  fi
}

resolve_pr_repo() {
  local pr="${1:-}"
  if [[ -n "${GH_REPO:-}" ]]; then
    echo "$GH_REPO"
    return
  fi
  if [[ -n "$pr" ]]; then
    gh pr view "$pr" --json headRepository -q .headRepository.nameWithOwner 2>/dev/null \
      || gh pr view "$pr" -R "${GH_REPO:-}" --json headRepository -q .headRepository.nameWithOwner 2>/dev/null \
      || true
  else
    gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true
  fi
}

# Run gh pr view with -R when repo is known (from GH_REPO or PR head).
gh_pr_view() {
  local pr="$1"
  shift
  local repo
  repo="$(resolve_pr_repo "$pr")"
  if [[ -n "$repo" ]]; then
    gh pr view "$pr" -R "$repo" "$@"
  else
    gh pr view "$pr" "$@"
  fi
}

# Run gh pr edit/checks with -R when repo is known.
gh_pr_cmd() {
  local subcmd="$1"
  local pr="$2"
  shift 2
  local repo
  repo="$(resolve_pr_repo "$pr")"
  if [[ -n "$repo" ]]; then
    gh pr "$subcmd" "$pr" -R "$repo" "$@"
  else
    gh pr "$subcmd" "$pr" "$@"
  fi
}
