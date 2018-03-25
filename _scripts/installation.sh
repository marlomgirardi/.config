#!/bin/sh

exists() { hash $1 2>/dev/null; }
not_exists() { ! exists $1; }
has_app() { test -d "/Applications/$1" || test -L "/Applications/$1"; }
has_font() { test $(ls /Library/Fonts/ | grep "$1" | wc -l) -gt 0 || test $(ls $HOME/Library/Fonts/ | grep "$1" | wc -l) -gt 0; } # TODO: change to test
brew_install() { echo "Install $1..."; brew install $1 1>/dev/null; }
install_font() { if ! has_font "$1"; then echo "Install $1..." && wget $2 -O "$HOME/Library/Fonts/$1" 2>/dev/null; fi; }
brew_cask_install() { echo $(brew cask install $1) | cut -d "'" -f2; }
mas_install() { echo $(mas install $1); }

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
  if not_exists mas; then brew_install mas; fi
  if not_exists fish; then brew_install fish; fi
else
  echo "Looks like brew isn't installed"
fi;

# FONTS - https://github.com/ryanoasis/nerd-fonts
install_font "DejaVu Sans Mono Nerd Regular.ttf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf?raw=true";

# APPS
if ! has_app "iTerm.app"; then brew_cask_install iterm; fi
if ! has_app "JetBrains Toolbox.app"; then brew_cask_install jetbrains-toolbox; fi
if ! has_app "Google Chrome.app"; then open -W "$(brew_cask_install google-chrome)"; fi
if ! has_app "Stremio.app"; then open -W "$(brew_cask_install stremio)"; fi
if ! has_app "Spotify.app"; then open -W "$(brew_cask_install spotify)"; fi
if ! has_app "Skype.app"; then open -W "$(brew_cask_install skype)"; fi
if ! has_app "Sequel Pro.app"; then open -W "$(brew_cask_install sequel-pro)"; fi
if ! has_app "Postman.app"; then open -W "$(brew_cask_install postman)"; fi
if ! has_app "MySQLWorkbench.app"; then open -W "$(brew_cask_install mysqlworkbench)"; fi
if ! has_app "AppCleaner.app"; then open -W "$(brew_cask_install AppCleaner)"; fi
if ! has_app "Cyberduck.app"; then open -W "$(brew_cask_install cyberduck)"; fi
if ! has_app "Macs Fan Control.app"; then open -W "$(brew_cask_install macs-fan-control)"; fi
if ! has_app "Backup and Sync.app" && ! has_app "Backup e sincronização do Google.app"; then open -W "$(brew_cask_install google-backup-and-sync)"; fi
# if ! has_app "zoom.us.app"; then open -W "$(brew_cask_install zoomus)"; fi
if ! has_app "MAMP PRO"; then open -W "$(brew_cask_install mamp)"; fi
if ! has_app "Adobe Creative Cloud"; then open -W "$(brew_cask_install adobe-creative-cloud)"; fi

if ! has_app "Xcode.app"; then mas_install "497799835"; fi
if ! has_app "Numbers.app"; then mas_install "409203825"; fi
if ! has_app "Pages.app"; then mas_install "409201541"; fi
if ! has_app "Keynote.app"; then mas_install "409183694"; fi
if ! has_app "Telegram.app"; then mas_install "747648890"; fi
if ! has_app "Spark.app"; then mas_install "1176895641"; fi
if ! has_app "Magnet.app"; then mas_install "441258766"; fi
if ! has_app "Evernote.app"; then mas_install "406056744"; fi
if ! has_app "Dashlane.app"; then mas_install "552383089"; fi
if ! has_app "Slack.app"; then mas_install "803453959"; fi
if ! has_app "WhatsApp.app"; then mas_install "1147396723"; fi
if ! has_app "Todoist.app"; then mas_install "585829637"; fi
if ! has_app "Lightshot Screenshot.app"; then mas_install "526298438"; fi

echo "Install fisher..."
curl -Lo "$1/fish/functions/fisher.fish" --create-dirs https://git.io/fisher 2>/dev/null

rm -r /usr/local/Caskroom/adobe-creative-cloud 2>/dev/null;

exit
