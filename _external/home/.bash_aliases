#!/usr/local/bin/fish
# https://github.com/marlomgirardi/MacOS

# Listing directory contents
if hash colorls 2>/dev/null;
	alias ls='colorls'
	alias l='ls -A'
	alias la='ls -lA --sd'
	alias lsd='ll -dA'
	alias lsf='ll -fA'
else
	alias l='ls -FA'
	alias lsd='ll | grep "^d"'
	alias lsf='ll | grep "^-"'
	alias la='ls -lA'
end;

alias ll='ls -l'

# File and directory find, if fd is not installed
# if not hash fd 2>/dev/null;
# 	alias f='find . -iname '
# 	alias ff='find . -type f -iname '
# 	alias fd='find . -type d -iname '
# end;

# Git aliases
# alias gb='git branch'
# alias gc='git checkout'
# alias gcb='git checkout -b'
# alias gcm='git commit -m'
# alias gad='git add --all'
# alias gps='git push'
# alias gpl='git pull'
# alias gd='git diff'
# # alias gds='git diff --cached'
# # alias gfl='git fetch --prune && git log -15'
# alias gf='git fetch --prune'
# # alias gfa='git fetch --all --tags --prune'
# alias gs='git status -sb'
# # alias gl='git log -15'
# # alias gll='git log'
# # alias gllp='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

# Shortcuts
alias c='clear'

# Storage
alias df='df -H'
alias du='du -ch'
alias dut='du -hsx * | sort -rh | head -10'

# Processes
alias psk='ps -ax | fzf --ansi | sed "s/^ *//" | cut -d " " -f1 | xargs -o kill'
alias pstree='pstree -g 3'

# A quick way to get out of current directory
# alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# vim: set ft=sh ts=2 sw=2 tw=120 noet :
