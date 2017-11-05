# https://github.com/marlomgirardi/MacOS

CNF_DIR="$HOME/.config"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Remove the ^S ^Q mappings. See all mappings: stty -a
stty stop undef
stty start undef

# Bash settings
shopt -s cdspell        # Autocorrects cd misspellings
shopt -s checkwinsize   # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist        # Save multi-line commands in history as single line
shopt -s dotglob        # Include dotfiles in pathname expansion
shopt -s expand_aliases # Expand aliases
shopt -s extglob        # Enable extended pattern-matching features
shopt -s histreedit     # Add failed commands to the bash history
shopt -s histappend     # Append each session's history to $HISTFILE
shopt -s histverify     # Edit a recalled history line before executing

export HISTSIZE=2000
export HISTFILESIZE=50000
export HISTTIMEFORMAT='[%F %T] '
export HISTIGNORE='history:pwd:jobs:ll:ls:l:fg:history:clear:exit'
export HISTCONTROL=ignoreboth
export HISTFILE="~/.bash_history"
export EDITOR=vim
export PAGER=less

# Source aliases
source $CNF_DIR/bash/.aliases

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# vim: set ft=sh ts=2 sw=2 tw=80 noet :
