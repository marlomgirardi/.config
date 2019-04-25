#!/bin/bash

# Ask for the administrator password
sudo -v;

# dir from this script (.config)
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

###########
# INSTALLATION SCRIPTS
###########

  for SCRIPT in installation launchpad defaults brew; do
    $DIR/_scripts/$SCRIPT.sh $DIR
  done

###########
# HOME
###########

  for FILE in vim vimrc; do
    rm -r "$HOME/.$FILE" 2>/dev/null
    ln -sf "$DIR/_external/home/.$FILE" $HOME
  done

###########
# VSCODE
###########

  # Create Links into VS Code directory
  VSCODE="$HOME/Library/Application Support/Code/User"
  for FILE in 'settings.json' 'keybindings.json'; do
    rm "$VSCODE/$FILE" 2>/dev/null
    ln -sf "$DIR/_external/vscode/$FILE" "$VSCODE/$FILE"
  done

  # Install extensions
  EXTENSIONS=$(cat "$DIR/_external/vscode/extensions")
  for EXT in $EXTENSIONS; do
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" --install-extension $EXT;
  done

###########
# SUBLIME TEXT
###########

  SUBLIME="$HOME/Library/Application Support/Sublime Text 3"

  # Package Control
  INSTALLED_PACKAGES="$SUBLIME/Installed Packages"
  if ! test -f "$INSTALLED_PACKAGES/Package Control.sublime-package"; then
    echo "Downloading Package Control.sublime-package...";
    curl "https://packagecontrol.io/Package%20Control.sublime-package" --output "$INSTALLED_PACKAGES/Package Control.sublime-package" &>/dev/null;
  fi;

  PACKAGES="$SUBLIME/Packages/User"
  for FILE in 'Package Control.sublime-settings' 'Preferences.sublime-settings'; do
    rm "$PACKAGES/$FILE" 2>/dev/null
    ln -sf "$DIR/_external/sublime-text-3/$FILE" "$PACKAGES/$FILE"
  done

fish "$DIR/_scripts/fish.fish"

exit