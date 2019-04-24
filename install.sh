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


fish "$DIR/_scripts/fish.fish"

exit