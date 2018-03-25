#!/bin/sh

exists() { hash $1 2>/dev/null; }
not_exists() { ! exists $1; }
has_app() { test $(ls /Applications/ | grep "$1.app" | wc -l) -gt 0; }
brew_install() { if not_exists $1; then echo "Install $1..."; brew install $1 1>/dev/null; fi }

if not_exists brew; then
  echo "Install brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 1>/dev/null
fi

if exists brew; then
  if not_exists htop; then
    brew_install htop
  fi

  if not_exists gls; then
    brew_install coreutils
  fi

  if not_exists colordiff; then
    brew_install colordiff
  fi

  if not_exists fzf; then
    brew_install fzf
  fi

  if not_exists pstree; then
    brew_install pstree
  fi

  if ! sh /usr/local/opt/nvm/nvm.sh 2>/dev/null; then
    brew_install nvm
  fi
else
  echo "Looks like brew isn't installed"
fi;

if ! has_app "iTerm"; then
  if not_exists wget; then
    brew_install wget
  fi

  if not_exists unzip; then
    brew_install unzip
  fi

  echo "Install iTerm..."
  wget -q https://iterm2.com/downloads/stable/latest
  unzip -q latest
  rm latest
  mv iTerm.app /Applications/
fi

