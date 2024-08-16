#!/usr/bin/zsh
# https://github.com/marlomgirardi/MacOS

# Listing directory contents
alias l='ls -FA'
alias la='ls -lA'
alias ll='ls -l'
alias lsd='ll | grep "^d"'
alias lsf='ll | grep "^-"'


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
alias gl='g l --no-merges'
alias glm='g lm'
alias gfco='g fco'

# Shortcuts
alias c='clear'

# A quick way to get out of current directory
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

# Grep
alias grep='rg'

# Processes
alias psk='ps -ax | fzf --ansi | sed "s/^ *//" | cut -d " " -f1 | xargs -o kill'

function killport() {
  kill -9 $(lsof -t -i:$1)
}
alias pk='killport'

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
for method in REQ_GET REQ_HEAD REQ_POST REQ_PUT REQ_DELETE REQ_TRACE REQ_OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}';

# NPM
alias ni='npm install'
alias nt='npm test'
alias nk='npm link'
alias nr='npm run'
alias ns='npm start'
alias nf='npm cache clean && rm -rf node_modules && npm install'
alias nlg='npm list --global --depth=0'

# PNPM
alias pn='pnpm'
alias pni='pnpm install'
alias pnad='pnpm add'
alias pnt='pnpm test'
alias pnr='pnpm run'
alias pns='pnpm start'
alias pnlg='pnpm list --global --depth=0'

# yarn
alias y='yarn'
alias yi='yarn install'
alias ya='yarn add'
alias yt='yarn test'
alias ns='npm start'
alias yf='yarn cache clean && rm -rf node_modules && yarn install'
alias ylg='yarn global list --depth=0'

jwt-decode() {
  # We can't use the simple @base64d due to jq not handling web-safe encoded base64: https://github.com/jqlang/jq/issues/2262
  # jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
  jq -R 'split(".") |.[0:2] | map(gsub("-"; "+") | gsub("_"; "/") | gsub("%3D"; "=") | @base64d) | map(fromjson)' <<< $1
}

# Not complete, but at least a quick way to update to the latest LTS version
nlts() {
  CURR_VERSION=$(node -v | tr -d 'v');
  LATEST_VERSION=$(nvm ls-remote --lts | tail -1 | awk '{print $1}' | tr -d 'v');

  echo "Do you want to migrate from Node.js $CURR_VERSION to $LATEST_VERSION ? (y/n)"
  read -k 1 REPLY

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    nvm i $LATEST_VERSION --reinstall-packages-from=$CURR_VERSION --latest-npm

    if [ -f .nvmrc ]; then
      sed -i '' "s/$CURR_VERSION/$LATEST_VERSION/g" .nvmrc
    fi
  fi
}

# vim: set ft=sh ts=2 sw=2 tw=120 noet :
