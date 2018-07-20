#!/usr/local/bin/fish
# https://github.com/marlomgirardi/MacOS

# Remove the ^S ^Q mappings.
stty stop undef
stty start undef

# TERMINAL CONFIG
export HISTSIZE=2000
export HISTFILESIZE=50000
export HISTIGNORE='history:pwd:jobs:fg:bg:l:ll:ls:la:lsd:lsf:history:clear:c:exit'
export HISTCONTROL=ignoreboth
export EDITOR=vim
export PAGER=less

# THEME CONFIG
set -g theme_display_git_master_branch yes
set -g theme_display_ruby no
set -g theme_display_docker_machine no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_project_dir_length 0
set -g fish_prompt_pwd_dir_length 0

# DONE CONFIG
# set -U __done_min_cmd_duration 20000 # default: 5000 ms
# set -U __done_exclude 'git (?!push|pull)' # default: all git commands, except push and pull. accepts a regex.

# Source aliases
source "$HOME/.config/_profile/.aliases"

set PATH /Users/marlom/.nvm/versions/node/v10.7.0/bin $PATH

# vim: set ft=sh ts=2 sw=2 tw=80 noet :
