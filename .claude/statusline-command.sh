#!/usr/bin/env bash
# Claude Code status line - inspired by Starship prompt layout

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

# 256-color ANSI codes
c_path=$'\033[38;5;75m'
c_git=$'\033[38;5;114m'
c_dirty=$'\033[38;5;203m'
c_dim=$'\033[2m'
c_reset=$'\033[0m'
c_ctx_warn=$'\033[22m\033[1m\033[38;5;221m'
c_ctx_danger=$'\033[1m\033[38;5;203m'

# Nerd font icons — hex bytes used because macOS bash 3.2 lacks \u support
icon_branch=$(printf '\xee\x82\xa0')  # U+E0A0 nf-pl-branch
icon_dirty=$(printf '\xef\x81\xaa')   # U+F06A nf-fa-exclamation_circle

# Shorten home directory to ~
home="$HOME"
short_cwd="${cwd/#$home/\~}"

# Git branch + dirty status (skip optional locks to avoid conflicts)
git_branch=""
if git_dir=$(git -C "$cwd" rev-parse --git-dir 2>/dev/null); then
  branch=$(git --git-dir="$git_dir" symbolic-ref --short HEAD 2>/dev/null \
    || git --git-dir="$git_dir" rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=""
    if ! git -C "$cwd" diff --quiet 2>/dev/null || ! git -C "$cwd" diff --cached --quiet 2>/dev/null; then
      dirty=" ${c_dirty}${icon_dirty}${c_reset}"
    fi
    git_branch=" | ${c_git}${icon_branch} ${branch}${c_reset}${dirty}"
  fi
fi

# Context: tokens used + used percentage
ctx_part=""
if [ -n "$used_pct" ] && [ "$ctx_size" -gt 0 ] 2>/dev/null; then
  used_tokens=$(printf '%.0f' "$(echo "$ctx_size * $used_pct / 100" | bc -l)")
  if [ "$used_tokens" -ge 1000000 ]; then
    fmt=$(printf '%.1fM' "$(echo "$used_tokens / 1000000" | bc -l)")
  elif [ "$used_tokens" -ge 1000 ]; then
    fmt=$(printf '%.1fk' "$(echo "$used_tokens / 1000" | bc -l)")
  else
    fmt="${used_tokens}"
  fi
  used_int=$(printf '%.0f' "$used_pct")
  if [ "$used_tokens" -ge 80000 ]; then
    c_tok="${c_ctx_danger}"
  elif [ "$used_tokens" -ge 40000 ]; then
    c_tok="${c_ctx_warn}"
  else
    c_tok=""
  fi
  ctx_part=" | ctx: ${c_tok}${fmt}${c_reset} (${used_int}%)"
fi

# Model
model_part=""
if [ -n "$model" ]; then
  model_part=" | $model"
fi

printf '%s%s%s%s' \
  "${c_path}${short_cwd}${c_reset}" \
  "$git_branch" \
  "${c_dim}${model_part}${c_reset}${ctx_part}"
