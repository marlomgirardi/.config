#!/bin/sh

exists() { hash $1 2>/dev/null; }
not_exists() { ! exists $1; }
has_app() { test -d "/Applications/$1" || test -L "/Applications/$1"; }
has_font() { test $(ls /Library/Fonts/ | grep "$1" | wc -l) -gt 0 || test $(ls $HOME/Library/Fonts/ | grep "$1" | wc -l) -gt 0; } # TODO: change to test
brew_install() { echo "Install $1..."; brew install $1 1>/dev/null; }
install_font() { if ! has_font "$1"; then echo "Install $1..." && wget $2 -O "$HOME/Library/Fonts/$1" 2>/dev/null; fi; }
brew_cask_install() { echo $(brew cask install $1) | cut -d "'" -f2; }

if not_exists brew; then
  echo "Install brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 1>/dev/null
fi

# COMMANDS
if exists brew; then
  if not_exists htop; then brew_install htop; fi
  if not_exists gls; then brew_install coreutils; fi
  if not_exists colordiff; then brew_install colordiff; fi
  if not_exists fzf; then brew_install fzf; fi
  if not_exists pstree; then brew_install pstree; fi
  if not_exists terminal-notifier; then brew_install terminal-notifier; fi
  if not_exists thefuck; then brew_install thefuck; fi
  if not_exists fish; then brew_install fish; fi
else
  echo "Looks like brew isn't installed"
fi;

# FONTS - https://github.com/ryanoasis/nerd-fonts
install_font "DejaVu Sans Mono Nerd Regular.ttf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf?raw=true";

# APPS
if ! has_app "iTerm.app"; then brew_cask_install iterm; fi
if ! has_app "JetBrains Toolbox.app"; then brew_cask_install jetbrains-toolbox; fi
if ! has_app "Adobe Creative Cloud"; then open -W "$(brew_cask_install adobe-creative-cloud)"; fi


echo "Install fisher..."
curl -Lo "$1/fish/functions/fisher.fish" --create-dirs https://git.io/fisher 2>/dev/null

rm -r /usr/local/Caskroom/adobe-creative-cloud 2>/dev/null;

exit
