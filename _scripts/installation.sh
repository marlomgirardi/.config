#!/bin/bash

exists() { hash $1 2>/dev/null; }
not_exists() { ! exists $1; }
download() { echo "Downloading $2..."; curl $3 --output "$1/$2" &>/dev/null; }

has_font() { ls "/Library/Fonts/$1" &>/dev/null || ls "$HOME/Library/Fonts/$1" &>/dev/null; }
install_font() { if ! has_font "$1"; then download "$HOME/Library/Fonts" "$1" "$2"; fi; }

exists_in_brew() { brew ls --versions $1 > /dev/null; }
brew_install() { echo "brew install $1 ..."; brew install $1 1>/dev/null; }
brew_cask_install() { echo "brew install --cask $1 ..."; brew install --cask $1 1>/dev/null; }

has_app() { test -d "/Applications/$1.app" || test -L "/Applications/$1.app"; }
mas_install() { echo $(mas install $1); }

#####
# Install Xcode Command Line
#####

# https://stackoverflow.com/questions/15371925/how-to-check-if-command-line-tools-is-installed
# https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
if not_exists gcc; then
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
  softwareupdate -i "$PROD" -a
fi;


#####
# Install Homebrew
#####

if not_exists brew; then
  # CI = 1 to do a simulate a CI bot and do it silently
  echo "Install brew..."
  CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Tap homebrew/cask-versions...";
brew tap homebrew/cask-versions


#####
# Brew packages
#####

if exists brew; then

  # Like cat, but better.
  if ! exists_in_brew nvim; then brew_install nvim; fi

  # Distributed revision control system
  if ! exists_in_brew git; then brew_install git; fi

  # Like cat, but better.
  if ! exists_in_brew bat; then brew_install bat; fi

  # Intuitive find CLI
  if ! exists_in_brew fd; then brew_install fd; fi

  # Another terminal based graphical activity monitor, inspired by gtop and vtop.
  if ! exists_in_brew gotop; then brew tap cjbassi/gotop; brew_install gotop; fi

  # Better man command
  if ! exists_in_brew tldr; then brew_install tldr; fi

  # It's an interactive Unix filter for command-line.
  if ! exists_in_brew fzf; then brew_install fzf; fi

  # Colorize logfiles and command output.
  if ! exists_in_brew grc; then brew_install grc; fi

  # Mac App Store command-line interface
  if ! exists_in_brew mas; then brew_install mas; fi

  # User-friendly command-line shell for UNIX-like operating systems
  if ! exists_in_brew fish; then brew_install fish; fi

  # https://github.com/antonmedv/fx
  if ! exists_in_brew fx; then brew_install fx; fi

  if ! exists_in_brew awscli; then brew_install awscli; fi

  # https://github.com/BurntSushi/ripgrep
  if ! exists_in_brew ripgrep; then brew_install ripgrep; fi;

  # Json processor
  # - needed by nx fish completion.
  if ! exists_in_brew jq; then brew_install jq; fi;

  # https://github.com/jesseduffield/lazydocker
  # if ! exists_in_brew lazydocker; then brew_install lazydocker; fi;

  # https://github.com/bcicen/ctop
  # if ! exists_in_brew ctop; then brew_install ctop; fi;

  # PGP
  # if ! exists_in_brew gpg2; then brew_install gpg2; fi
  # if ! exists_in_brew gnupg; then brew_install gnupg; fi
  # if ! exists_in_brew pinentry-mac; then brew_install pinentry-mac; fi
else
  echo "Looks like brew isn't installed"
fi;


#####
# Ruby Gems
#####

# Install latest ruby version.
brew_install ruby;

# A Ruby gem that beautifies the terminal's ls command.
if not_exists colorls; then sudo gem install colorls; fi;


#####
# Fonts
# Automatic option: https://github.com/Homebrew/homebrew-cask-fonts
#####

# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DejaVuSansMono
install_font "DejaVu Sans Mono Bold Oblique Nerd Font Complete.ttf" "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Bold-Italic/complete/DejaVu%20Sans%20Mono%20Bold%20Oblique%20Nerd%20Font%20Complete.ttf";
install_font "DejaVu Sans Mono Bold Nerd Font Complete.ttf" "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Bold/complete/DejaVu%20Sans%20Mono%20Bold%20Nerd%20Font%20Complete.ttf";
install_font "DejaVu Sans Mono Italic Nerd Font Complete.ttf" "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Italic/complete/DejaVu%20Sans%20Mono%20Oblique%20Nerd%20Font%20Complete.ttf";
install_font "DejaVu Sans Mono Nerd Regular.ttf" "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf";

# https://github.com/JetBrains/JetBrainsMono
install_font "JetBrainsMono-Thin.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-Thin.ttf"
install_font "JetBrainsMono-ThinItalic.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-ThinItalic.ttf"
install_font "JetBrainsMono-ExtraLight.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-ExtraLight.ttf"
install_font "JetBrainsMono-ExtraLightItalic.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-ExtraLightItalic.ttf"
install_font "JetBrainsMono-Light.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-Light.ttf"
install_font "JetBrainsMono-LightItalic.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-LightItalic.ttf"
install_font "JetBrainsMono-BoldItalic.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-BoldItalic.ttf"
install_font "JetBrainsMono-Bold.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-Bold.ttf"
install_font "JetBrainsMono-Italic.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-Italic.ttf"
install_font "JetBrainsMono-Regular.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-Regular.ttf"
install_font "JetBrainsMono-ExtraBoldItalic.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-ExtraBoldItalic.ttf"
install_font "JetBrainsMono-ExtraBold.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-ExtraBold.ttf"
install_font "JetBrainsMono-MediumItalic.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-MediumItalic.ttf"
install_font "JetBrainsMono-Medium.ttf" "https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/ttf/JetBrainsMono-Medium.ttf"

######
# Apps
######

# Development
if ! has_app "Visual Studio Code"; then brew_cask_install visual-studio-code; fi
if ! has_app "Sublime Text"; then brew_cask_install sublime-text; fi
if ! has_app "iTerm"; then brew_cask_install iterm2; fi
if ! has_app "Firefox Developer Edition"; then brew_cask_install firefox-developer-edition; fi
if ! has_app "Postman"; then brew_cask_install postman; fi
if ! has_app "Adobe Creative Cloud"; then brew_cask_install adobe-creative-cloud; fi
#if ! has_app "TablePlus"; then brew_cask_install tableplus; fi
#if ! has_app "Cyberduck"; then brew_cask_install cyberduck; fi
if ! has_app "Docker"; then brew_cask_install docker; fi
# if ! has_app "JetBrains Toolbox"; then brew_cask_install jetbrains-toolbox; fi

if ! has_app "Ganache"; then brew_cask_install ganache; fi

# Utils
if ! has_app "Raycast"; then brew_cask_install raycast; fi
if ! has_app "AppCleaner"; then brew_cask_install AppCleaner; fi
if ! has_app "iStat Menus"; then mas_install "1319778037"; fi
if ! has_app "Kap"; then brew_cask_install kap; fi
if ! has_app "Authy Desktop"; then brew_cask_install authy; fi
if ! has_app "AdGuard"; then brew_cask_install adguard; fi
if ! has_app "draw.io"; then brew_cask_install drawio; fi
if ! has_app "Velja"; then mas_install "1607635845"; fi # testing
if ! has_app "Hidden Bar"; then mas_install "1452453066"; fi
if ! has_app "Shottr"; then brew_cask_install shottr; fi # testing
if ! has_app "One Thing"; then mas_install "1604176982"; fi
if ! has_app "Dropover"; then mas_install "1355679052"; fi # testing

# Office
if ! has_app "Notion"; then brew_cask_install notion; fi
if ! has_app "Google Drive"; then brew_cask_install google-drive; fi
if ! has_app "Numbers"; then mas_install "409203825"; fi
if ! has_app "Pages"; then mas_install "409201541"; fi
if ! has_app "Spark"; then mas_install "1176895641"; fi
if ! has_app "Kindle"; then mas_install "405399194"; fi
if ! has_app "TradingView"; then brew_cask_install tradingview; fi

# General
if ! has_app "Orion"; then brew_cask_install orion; fi # testing
if ! has_app "Google Chrome"; then brew_cask_install google-chrome; fi
if ! has_app "Brave Browser"; then brew_cask_install microsoft-edge; fi
if ! has_app "Microsoft Edge"; then brew_cask_install brave-browser; fi
if ! has_app "Spotify"; then brew_cask_install spotify; fi
if ! has_app "Stremio"; then brew_cask_install stremio; fi
if ! has_app "IINA"; then brew_cask_install iina; fi

# Chat
if ! has_app "Discord"; then brew_cask_install discord; fi
if ! has_app "Slack"; then mas_install "803453959"; fi
if ! has_app "WhatsApp"; then mas_install "1147396723"; fi
if ! has_app "Telegram"; then mas_install "747648890"; fi

# Screen Saver
# https://github.com/dessibelle/Blue-Screen-Saver
if ! test -d "$HOME/Library/Screen Savers/Blue Screen Saver.saver"; then
    echo "Copy screen saver...";
    curl "https://www.dropbox.com/s/30upmkpsdkyvjug/Blue-Screen-Saver.saver.zip?dl=1" -sLo "/tmp/saver.zip" 1>/dev/null;
    unzip /tmp/saver.zip -d "$HOME/Library/Screen Savers/"
fi;

echo "Install OMF...";
curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

if ! test -d "$HOME/.nvm"; then
    echo "Install NVM...";
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi;

######
# Custom directories
######

if ! test -d "$HOME/Library/Projects/"; then
  echo "Create Projects directory ...";
  mkdir "$HOME/Library/Projects/";
fi;
