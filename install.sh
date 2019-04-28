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

  for FILE in vim vimrc bashrc; do
    rm -r "$HOME/.$FILE" 2>/dev/null
    ln -sf "$DIR/_external/home/.$FILE" $HOME
  done

###########
# VSCODE
###########

  # Install sync extension
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" --install-extension "Shan.code-settings-sync";

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