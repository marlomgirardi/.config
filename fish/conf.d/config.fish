#!/usr/local/bin/fish
# https://github.com/marlomgirardi/MacOS

function _i --description 'Convert unicode code to icon'
    printf "\u$argv"
end


##########################
# THEME CONFIG
##########################

# PROMPT
set SPACEFISH_CHAR_SYMBOL (_i "f061")

# EXIT CODE
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

# DIR
set SPACEFISH_DIR_LOCK_SYMBOL (_i "f840")

# vim: set ft=sh ts=2 sw=2 tw=120 noet :
