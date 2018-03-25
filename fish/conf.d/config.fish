#!/usr/local/bin/fish
# https://github.com/marlomgirardi/MacOS

# Remove the ^S ^Q mappings. See all mappings: stty -a
stty stop undef
stty start undef

export HISTSIZE=2000
export HISTFILESIZE=50000
export HISTIGNORE='history:pwd:jobs:fg:bg:ll:ls:la:history:clear:c:exit'
export HISTCONTROL=ignoreboth
export EDITOR=vim
export PAGER=less

set -g theme_display_git_master_branch yes
set -g theme_display_ruby no
set -g theme_display_docker_machine no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_project_dir_length 0
set -g fish_prompt_pwd_dir_length 0

# set -g theme_display_user yes
# set -g theme_display_hostname yes
# set -g theme_display_git yes
# set -g theme_display_git_dirty yes
# set -g theme_display_git_untracked yes
# set -g theme_display_git_ahead_verbose yes
# set -g theme_display_git_dirty_verbose yes
# set -g theme_git_worktree_support yes
# set -g theme_display_vagrant yes
# set -g theme_display_k8s_context no
# set -g theme_display_hg yes
# set -g theme_display_virtualenv no
# set -g theme_display_vi no
# set -g theme_avoid_ambiguous_glyphs yes
# set -g theme_powerline_fonts no
# set -g default_user your_normal_user
# set -g theme_color_scheme dark
# set -g theme_newline_cursor yes

# Source aliases
source "$HOME/.config/_profile/.aliases"

# vim: set ft=sh ts=2 sw=2 tw=80 noet :
