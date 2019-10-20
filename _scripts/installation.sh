#!/bin/bash

exists() { hash $1 2>/dev/null; }
not_exists() { ! exists $1; }
download() { echo "Downloading $2..."; curl $3 --output "$1/$2" &>/dev/null; }

has_font() { ls "/Library/Fonts/$1" &>/dev/null || ls "$HOME/Library/Fonts/$1" &>/dev/null; }
install_font() { if ! has_font "$1"; then download "$HOME/Library/Fonts" "$1" "$2"; fi; }



exists_in_brew() { brew ls --versions $1 > /dev/null; }
brew_install() { echo "brew install $1 ..."; brew install $1 1>/dev/null; }
brew_cask_install() { echo "brew cask install $1 ..."; brew cask install $1 1>/dev/null; }

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
  softwareupdate -i "$PROD" -v
fi;


#####
# Install Homebrew
#####

if not_exists brew; then
  # CI = 1 to do a simulate a CI bot and do it silently
  echo "Install brew..."
  CI=1 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Tap homebrew/cask-versions...";
brew tap homebrew/cask-versions


#####
# Brew packages
#####

if exists brew; then

  # Check outdated libraries
  if ! exists brew cu; then brew tap buo/cask-upgrade; fi

  # Distributed revision control system
  if ! exists_in_brew git; then brew_install git; fi

  # Improved top (interactive process viewer)
  if ! exists_in_brew htop; then brew_install htop; fi

  # Color-highlighted diff(1) output
  # if ! exists_in_brew colordiff; then brew_install colordiff; fi

  # Show ps output as a tree
  if ! exists_in_brew pstree; then brew_install pstree; fi

  # It's an interactive Unix filter for command-line.
  if ! exists_in_brew fzf; then brew_install fzf; fi

  # Send User Notifications on macOS from the command-line.
  if ! exists_in_brew terminal-notifier; then brew_install terminal-notifier; fi

  # Colorize logfiles and command output.
  if ! exists_in_brew grc; then brew_install grc; fi

  # Mac App Store command-line interface
  if ! exists_in_brew mas; then brew_install mas; fi

  # User-friendly command-line shell for UNIX-like operating systems
  if ! exists_in_brew fish; then brew_install fish; fi

  # https://github.com/antonmedv/fx
  if ! exists_in_brew fx; then brew_install fx; fi

  if ! exists_in_brew awscli; then brew_install awscli; fi

  # https://github.com/wting/autojump
  if ! exists_in_brew autojump; then brew_install autojump; fi
else
  echo "Looks like brew isn't installed"
fi;


#####
# Ruby Gems
#####

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

# https://github.com/tonsky/FiraCode
install_font "FiraCode-Bold.ttf" "https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Bold.ttf";
install_font "FiraCode-Light.ttf" "https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Light.ttf";
install_font "FiraCode-Medium.ttf" "https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Medium.ttf";
install_font "FiraCode-Regular.ttf" "https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Regular.ttf";
install_font "FiraCode-Retina.ttf" "https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Retina.ttf";


######
# Apps
######

# Development
if ! has_app "Visual Studio Code"; then brew_cask_install visual-studio-code; fi
if ! has_app "Sublime Text"; then brew_cask_install sublime-text; fi
if ! has_app "Sequel Pro"; then brew_cask_install sequel-pro; fi # Replace by TablePlus?
if ! has_app "TablePlus"; then brew_cask_install tableplus; fi
if ! has_app "Cyberduck"; then brew_cask_install cyberduck; fi
if ! has_app "iTerm"; then brew_cask_install iterm2; fi
if ! has_app "Dash"; then brew_cask_install dash; fi
if ! has_app "Firefox Developer Edition"; then brew_cask_install firefox-developer-edition; fi
# if ! has_app "Docker"; then brew_cask_install docker; fi
# if ! has_app "JetBrains Toolbox"; then brew_cask_install jetbrains-toolbox; fi
# if ! has_app "Postman"; then brew_cask_install postman; fi
# if ! has_app "MySQLWorkbench"; then brew_cask_install mysqlworkbench; fi
# if ! has_app "MAMP PRO"; then brew_cask_install mamp; fi
# if ! has_app "Adobe Creative Cloud"; then brew_cask_install adobe-creative-cloud; fi
# if ! has_app "Xcode"; then mas_install "497799835"; fi

# Utils
if ! has_app "Macs Fan Control"; then brew_cask_install macs-fan-control; fi
if ! has_app "AppCleaner"; then brew_cask_install AppCleaner; fi
if ! has_app "Magnet"; then mas_install "441258766"; fi
if ! has_app "Lightshot Screenshot"; then mas_install "526298438"; fi
if ! has_app "iStat Menus"; then mas_install "1319778037"; fi
if ! has_app "GIF Brewery 3"; then mas_install "1081413713"; fi
if ! has_app "RunJS"; then brew_cask_install runjs; fi

# Office
if ! has_app "Backup and Sync"; then brew_cask_install google-backup-and-sync; fi
if ! has_app "Grammarly"; then brew_cask_install grammarly; fi
if ! has_app "Numbers"; then mas_install "409203825"; fi
if ! has_app "Pages"; then mas_install "409201541"; fi
if ! has_app "Keynote"; then mas_install "409183694"; fi
if ! has_app "Spark"; then mas_install "1176895641"; fi
if ! has_app "Evernote"; then mas_install "406056744"; fi
if ! has_app "Dashlane"; then mas_install "552383089"; fi
if ! has_app "Kindle"; then mas_install "405399194"; fi
if ! has_app "Bear"; then mas_install "1091189122"; fi

# General
if ! has_app "Google Chrome"; then brew_cask_install google-chrome; fi
if ! has_app "Stremio"; then brew_cask_install stremio; fi
if ! has_app "Spotify"; then brew_cask_install spotify; fi

# Chat
if ! has_app "Franz"; then brew_cask_install franz; fi
# if ! has_app "Gitter"; then brew_cask_install gitter; fi
# if ! has_app "Discord"; then brew_cask_install discord; fi
if ! has_app "Skype"; then brew_cask_install skype; fi
if ! has_app "Slack"; then mas_install "803453959"; fi
# if ! has_app "WhatsApp"; then mas_install "1147396723"; fi
# if ! has_app "Telegram"; then mas_install "747648890"; fi

# Screen Saver
# https://github.com/dessibelle/Blue-Screen-Saver
if ! test -d "$HOME/Library/Screen Savers/Blue Screen Saver.saver"; then
    echo "Copy screen saver...";
    curl "https://www.dropbox.com/s/30upmkpsdkyvjug/Blue-Screen-Saver.saver.zip?dl=1" -sLo "/tmp/saver.zip" 1>/dev/null;
    unzip /tmp/saver.zip -d "$HOME/Library/Screen Savers/"
fi;

echo "Install OMF...";
curl -L https://get.oh-my.fish | fish

if ! test -d "$HOME/.nvm"; then
    echo "Install NVM...";
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
fi;

# rm -r /usr/local/Caskroom/adobe-creative-cloud 2>/dev/null;

######
# Custom directories
######

if ! test -d "$HOME/Library/Projects/"; then
  echo "Create Projects directory ...";
  mkdir "$HOME/Library/Projects/";
fi;
