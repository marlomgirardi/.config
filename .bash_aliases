#!/usr/local/bin/fish
# https://github.com/marlomgirardi/MacOS

# Listing directory contents
alias ls='colorls'
alias l='ls -A'
alias la='ls -lA --sd'
alias ll='ls -l'
alias lsd='ll -dA'
alias lsf='ll -fA'
# alias l='ls -FA'
# alias lsd='ll | grep "^d"'
# alias lsf='ll | grep "^-"'
# alias la='ls -lA'


# Git aliases
alias g='git'
alias gb='g branch'
alias gc='g checkout'
alias gcb='g checkout -b'
alias gcm='g commit -m'
alias ga='g a'
alias gps='g ps'
alias gpl='g pl'
alias gf='g f'
alias gs='g s'
alias gl='g l'
alias glm='g lm'

# Shortcuts
alias c='clear'

# Docker
alias lzd='lazydocker'

# A quick way to get out of current directory
# alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# Grep
alias grep='ripgrep'

# Storage
alias df='df -H'
alias du='du -ch'
alias dut='du -hsx * | sort -rh | head -10'

# Processes
alias psk='ps -ax | fzf --ansi | sed "s/^ *//" | cut -d " " -f1 | xargs -o kill'

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# IP addresses
alias ip="curl ipecho.net/plain"
alias ipv6="curl icanhazip.com"
alias localip="ipconfig getifaddr en0"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# CLI requests
alias GET="lwp-request -m 'GET'"
alias HEAD="lwp-request -m 'HEAD'"
alias POST="lwp-request -m 'POST'"
alias PUT="lwp-request -m 'PUT'"
alias DELETE="lwp-request -m 'DELETE'"
alias TRACE="lwp-request -m 'TRACE'"
alias OPTIONS="lwp-request -m 'OPTIONS'"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Print each PATH entry on a separate line
alias path='echo -e {$PATH \\n}'; # fish
# alias path='echo -e ${PATH//:/\\n}'; #bash

# NPM
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install --global'
alias nt='npm test'
alias nit='npm install && npm test'
alias nk='npm link'
alias nr='npm run'
alias ns='npm start'
alias nf='npm cache clean && rm -rf node_modules && npm install'
alias nlg='npm list --global --depth=0'

# yarn
alias yi='yarn install'
alias ya='yarn add'
alias yt='yarn test'
alias yit='yarn install && yarn test'
alias ns='npm start'
alias yf='yarn cache clean && rm -rf node_modules && yarn install'
alias ylg='yarn global list --depth=0'

# vim: set ft=sh ts=2 sw=2 tw=120 noet :
