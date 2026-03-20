#!/usr/bin/env bash
# Claude Code status line - inspired by Starship prompt layout

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# 256-color ANSI codes
c_path=$'\033[38;5;75m'
c_git=$'\033[38;5;114m'
c_dirty=$'\033[38;5;203m'
c_node=$'\033[38;5;71m'
c_dim=$'\033[2m'
c_reset=$'\033[0m'
c_ctx_warn=$'\033[1m\033[38;5;221m'
c_ctx_danger=$'\033[1m\033[38;5;203m'

# Nerd font icons — hex bytes used because macOS bash 3.2 lacks \u support
icon_branch=$(printf '\xee\x82\xa0')  # U+E0A0 nf-pl-branch
icon_dirty=$(printf '\xef\x81\xaa')   # U+F06A nf-fa-exclamation_circle
icon_node=$(printf '\xee\x9c\x98')    # U+E718 nf-dev-nodejs

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

# Node.js version
node_part=""
node_bin=""
if command -v node >/dev/null 2>&1; then
  node_bin="node"
else
  nvm_latest=$(ls "$HOME/.nvm/versions/node/" 2>/dev/null | sort -V | tail -1)
  if [ -n "$nvm_latest" ]; then
    node_bin="$HOME/.nvm/versions/node/$nvm_latest/bin/node"
  fi
fi
if [ -n "$node_bin" ]; then
  node_version=$("$node_bin" --version 2>/dev/null)
  if [ -n "$node_version" ]; then
    node_part=" | ${c_node}${icon_node} ${node_version}${c_reset}"
  fi
fi

# Context remaining
ctx_part=""
if [ -n "$remaining" ]; then
  if [ "$remaining" -le 10 ]; then
    ctx_part=" | ${c_ctx_danger}ctx: ${remaining}%${c_reset}"
  elif [ "$remaining" -le 20 ]; then
    ctx_part=" | ${c_ctx_warn}ctx: ${remaining}%${c_reset}"
  else
    ctx_part=" | ctx: ${remaining}%"
  fi
fi

# Model
model_part=""
if [ -n "$model" ]; then
  model_part=" | $model"
fi

printf '%s%s%s%s%s%s%s' \
  "${c_path}${short_cwd}${c_reset}" \
  "$git_branch" \
  "$node_part" \
  "${c_dim}${model_part}${ctx_part}${c_reset}"
