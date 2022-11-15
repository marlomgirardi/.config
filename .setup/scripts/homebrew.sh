#!/bin/bash

#####
# Install Homebrew
#####

if not_exists brew; then
  # CI = 1 to do a simulate a CI bot and do it silently
  echo "Install brew..."
  CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  # Brew on current shell
  export HOMEBREW_BUNDLE_FILE="$HOME/.config/.setup/backup/Brewfile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#####
# Install from Brewfile
#####

echo "Installing from Brewfile..."
brew bundle --no-lock --quiet
