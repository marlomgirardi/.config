#!/usr/local/bin/fish
# https://github.com/marlomgirardi/MacOS

function _i --description 'Convert unicode code to icon'
    printf "\u$argv"
end

# Remove the ^S ^Q mappings.
stty stop undef
stty start undef

# TERMINAL CONFIG
set HISTIGNORE history pwd jobs fg bg l ll ls la lsd lsf clear c exit
set -gx LC_ALL en_US.UTF-8
set -gx EDITOR vim
set -gx VISUAL vim
set -gx GIT_EDITOR vim
set -gx GPG_TTY (tty)

set -x PATH ~/Library/Python/2.7/bin $PATH

set -gx LDFLAGS "-L/usr/local/opt/ruby/lib" "-L/usr/local/opt/sqlite/lib"
set -gx CPPFLAGS "-I/usr/local/opt/ruby/include" "-I/usr/local/opt/sqlite/include"
set -g fish_user_paths "/usr/local/opt/sqlite/bin" "/usr/local/lib/ruby/gems/2.7.0/bin" "/usr/local/opt/ruby/bin" $fish_user_paths

# set -gx VIMRUNTIME /usr/share/vim/vim81
# set -gx VIM ~/.config/vim
# /bin/ls /usr/share/vim/ | grep -e "vim[0-9]"

##########################
# THEME CONFIG
##########################

# Disable some things
set SPACEFISH_TIME_SHOW false
set SPACEFISH_USER_SHOW false
set SPACEFISH_HOST_SHOW false
set SPACEFISH_JULIA_SHOW false
set SPACEFISH_RUBY_SHOW false
set SPACEFISH_HASKELL_SHOW false
set SPACEFISH_AWS_SHOW false
set SPACEFISH_VENV_SHOW false
set SPACEFISH_CONDA_SHOW false
set SPACEFISH_PYENV_SHOW false
set SPACEFISH_GOLANG_SHOW false
set SPACEFISH_PHP_SHOW false
set SPACEFISH_RUST_SHOW false
set SPACEFISH_DOTNET_SHOW false
set SPACEFISH_KUBECONTEXT_SHOW false
set SPACEFISH_VI_MODE_SHOW false
set SPACEFISH_DOCKER_SHOW false

# PROMPT
# default: time user dir host git package node docker ruby golang php rust haskell julia aws conda pyenv kubecontext exec_time line_sep battery jobs exit_code char
set SPACEFISH_PROMPT_ORDER dir git package node exec_time line_sep battery jobs exit_code char
set SPACEFISH_CHAR_SYMBOL (_i "f061")

# EXIT CODE
set SPACEFISH_EXIT_CODE_SHOW true
set SPACEFISH_EXIT_CODE_SYMBOL "✘ "

# GIT
set SPACEFISH_GIT_BRANCH_PREFIX (_i "f418 ") # Prefix before Git branch subsection
set SPACEFISH_GIT_STATUS_UNTRACKED ? # Indicator for untracked changes
set SPACEFISH_GIT_STATUS_ADDED + # Indicator for added changes
set SPACEFISH_GIT_STATUS_MODIFIED ! # Indicator for unstaged files
set SPACEFISH_GIT_STATUS_RENAMED » # Indicator for renamed files
set SPACEFISH_GIT_STATUS_DELETED ✘ # Indicator for deleted files
set SPACEFISH_GIT_STATUS_STASHED '$' # Indicator for stashed changes
set SPACEFISH_GIT_STATUS_UNMERGED = # Indicator for unmerged changes
set SPACEFISH_GIT_STATUS_AHEAD ↑ # Indicator for unpushed changes (ahead of remote branch)
set SPACEFISH_GIT_STATUS_BEHIND ↓ # Indicator for unpulled changes (behind of remote branch)
set SPACEFISH_GIT_STATUS_DIVERGED ↕︎ # Indicator for diverged chages (diverged with remote branch)

# BATTERY
set SPACEFISH_BATTERY_SHOW true
set SPACEFISH_BATTERY_SYMBOL_CHARGING (_i "f58e ")
set SPACEFISH_BATTERY_SYMBOL_DISCHARGING (_i "f58b ")
set SPACEFISH_BATTERY_SYMBOL_FULL (_i "f578 ")

# DIR
set SPACEFISH_DIR_LOCK_SYMBOL (_i "f840")

# PJ CONFIG
set -gx PROJECT_PATHS ~/Library/Projects

# Source aliases
source "$HOME/.config/_external/.bash_aliases"

# Use default node
nvm use default --silent

# TODO: see a way to dont write in history and maintain the arrow up history
function ignorehistory --on-event fish_postexec -d "Simulate HISTIGNORE from bash"
    set COMMAND (echo $argv[1] | head -n1 | cut -d " " -f1)
    if contains -i $COMMAND $HISTIGNORE 1>/dev/null
        # history delete --case-sensitive --exact $argv
        history delete --case-sensitive --exact $COMMAND
    end
end

# vim: set ft=sh ts=2 sw=2 tw=120 noet :
