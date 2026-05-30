---
name: work-on
description: "Execute a unit of work end-to-end without pausing for permission: implement, commit, deep-code-reviewer loop, open PR, CI loop, Copilot review loop, until merge-ready. Use when user wants to do work, build a feature, fix a bug, implement an issue, or run work-on."
---

# Work on

Execute a complete unit of work through merge-ready PR — **without asking the user to continue between steps**.

## Autonomous mode (required)

Run the full pipeline below in one session. **Do not** stop after each phase to ask "should I continue?", "want me to fix CI?", or "should I request Copilot?".

**Only interrupt the user when:**

- Scope is ambiguous and you cannot infer intent from the issue, PRD, or codebase.
- You need a secret, credential, or manual action only a human can perform.
- A merge conflict requires a product decision (conflicting intents, not mechanical resolution).
- CI fails for reasons **outside this PR's scope** and changing workflows or unrelated code would be required.
- You hit a hard timeout (e.g. Copilot review not submitted after 30 minutes) — report status and what remains.

**At the end:** post a short summary (PR link, CI status, reviews addressed, anything left for human QA) and ask for **manual review** — that is the only expected human gate.

For optional review feedback (Nit / Optional / Consider): apply when it clearly improves correctness or maintainability; otherwise note the deferral in a PR comment — **do not** ask the user per comment.

## Managing the ticket

- Before starting: move issue to **in progress**.
- After implementation (pre-PR): move to **review** if your tracker uses that state.
- When the pipeline below is fully green and reviewer loops are done: leave in **review** for human merge approval (unless the project says otherwise).

## Cursor: how to wait (do not skip)

Cursor **can** wait. Use these mechanisms — they block until the step is done:

| Step | How to wait |
|------|-------------|
| Deep code review subagent | `Task` with `subagent_type: "deep-code-reviewer"` and **`run_in_background: false`** (default). Do not continue until the subagent returns. Never fire-and-forget. **Prefix the task with `[work-on]`** so the Cursor `subagentStop` hook auto-continues the pipeline when the review finishes. |
| Local validation / tests | Run in `Shell`; command blocks until exit. |
| CI on GitHub | `~/.config/.agents/skills/work-on/scripts/wait-pr-checks.sh [pr] [interval]` or `gh pr checks <pr> --watch --interval 30` |
| Copilot review | `gh pr edit <pr> --add-reviewer copilot` then `scripts/wait-reviewer-review.sh` |
| Long shell jobs | `Await` if you intentionally backgrounded a shell |

If a subagent was started in the background by mistake, do not proceed — wait for its completion notification or re-run the review in the foreground.

Helper scripts (repo-agnostic, require `gh` auth):

```bash
# After push — block until all checks pass or fail
~/.config/.agents/skills/work-on/scripts/wait-pr-checks.sh

# After requesting Copilot — block until review or inline comments exist
~/.config/.agents/skills/work-on/scripts/wait-reviewer-review.sh copilot

# Gather feedback to implement
~/.config/.agents/skills/work-on/scripts/list-pr-feedback.sh copilot
```

---

## Pipeline

Complete every phase in order. Each phase has a **done when** — do not advance until it is satisfied.

### Phase 1 — Understand

Read the issue, linked PRD/plan, and explore the codebase (LSP preferred per AGENTS.md).

**Done when:** You can state the acceptance criteria and the files/areas to change.

If scope is ambiguous → ask the user **once**, then continue the pipeline without further checkpoints.

### Phase 2 — Implement

**Backend:** red/green/refactor, one test at a time (tracer-bullet). One failing test → make it pass → next slice → refactor if needed.

**Frontend:** implement directly (no TDD unless the project requires it).

Match existing patterns; minimal diff.

### Phase 3 — Validate locally

```bash
pnpm run typecheck
pnpm run test
```

Fix until both pass. Repeat as needed.

**Done when:** typecheck and tests are green locally.

### Phase 4 — Commit and open PR

1. Commit with a clear message (why, not just what).
2. Push branch: `git push -u origin HEAD`
3. Create PR: `gh pr create` with summary + test plan (or update existing PR if branch already has one).

**Done when:** PR exists on GitHub and branch is pushed.

### Phase 5 — Deep code review loop

1. Launch **`deep-code-reviewer`** on the PR diff (foreground `Task`). The **first line of the task must be `[work-on]`**. Include branch name, issue/PR link, acceptance criteria, and "return blocking issues vs optional suggestions with file:line".
2. **Wait** for the subagent to finish.
3. Implement all **blocking / required / critical** findings. For optional items, use judgment (see Autonomous mode).
4. Commit and push: `git push`
5. Run **Phase 6 (CI)** until green.
6. If the review requested material changes, **re-run `deep-code-reviewer`** on the updated diff. Repeat until no blockers remain.

**Done when:** deep-code-reviewer has no blocking items and CI is green.

### Phase 6 — CI loop

After every push to the PR branch:

```bash
~/.config/.agents/skills/work-on/scripts/wait-pr-checks.sh <pr-number>
```

On failure:

1. Read failed check logs: `gh run view <run-id> --log-failed` or the check URL from `gh pr checks`.
2. Fix within PR scope.
3. Commit with a message explaining **why** (e.g. `fix(ci): restore mock for revoked session in webhook test`).
4. Push and **wait again** until all checks pass.

**Do not** change CI workflows or unrelated code to make checks pass.

**Done when:** `gh pr checks` reports all required checks passing (exit 0 after `--watch`).

### Phase 7 — Copilot review loop

Only start when Phase 6 is green.

1. Request reviewer:
   ```bash
   gh pr edit <number> --add-reviewer copilot
   ```
2. Wait for Copilot:
   ```bash
   ~/.config/.agents/skills/work-on/scripts/wait-reviewer-review.sh copilot <number>
   ```
3. List feedback:
   ```bash
   ~/.config/.agents/skills/work-on/scripts/list-pr-feedback.sh copilot <number>
   ```
4. Address **all** Copilot comments that are valid bugs, correctness issues, or clear improvements. Skip only when wrong — reply on the thread with reasoning.
5. Commit, push, run **Phase 6** again until green.
6. If Copilot left new comments on the new commits, repeat from step 2 (re-request reviewer only if Copilot did not auto re-review).

**Done when:** Copilot review is complete (no new unresolved valid comments) and CI is green.

### Phase 8 — Hand off

Post a PR comment or update the description with:

- What was implemented
- Review rounds completed (deep-code-reviewer + Copilot)
- CI status
- Anything deferred or needing human QA (manual Clerk dashboard steps, etc.)

Tell the user the PR is **ready for manual review**.

---

## Quick reference

```bash
# CI
gh pr checks <n> --watch --interval 30

# Copilot
gh pr edit <n> --add-reviewer copilot
~/.config/.agents/skills/work-on/scripts/wait-reviewer-review.sh copilot <n>
~/.config/.agents/skills/work-on/scripts/list-pr-feedback.sh copilot <n>
```

## Cursor hook (auto-continue)

When `deep-code-reviewer` completes a `[work-on]` task, `.cursor/hooks/work-on-subagent-stop.sh` injects a `followup_message` so the parent agent continues Phases 5–7 without a new user prompt. Config: `.cursor/hooks.json` (`subagentStop`, `loop_limit: null`).

## See also

- Multi-axis review criteria: `code-review` skill
- PR comment + CI triage patterns: `babysit` skill (Cursor)
