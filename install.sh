#!/bin/bash

# Ask for the administrator password
sudo -v;

# dir from this script (.config)
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

###########
# INSTALLATION SCRIPTS
###########

for SCRIPT in installation defaults brew; do
  $DIR/_scripts/$SCRIPT.sh $DIR
done

###########
# HOME
###########

for FILE in vim vimrc bashrc .zshrc; do
  rm -r "$HOME/.$FILE" 2>/dev/null
  ln -sf "$DIR/_external/home/.$FILE" $HOME
done

###########
# VSCODE
###########

  # Install sync extension
  if [ $(code --list-extensions | grep -c "Shan.code-settings-sync") -eq 0 ]; then
    echo "Installing VSCode Settings sync...";
    code --install-extension "Shan.code-settings-sync";
  fi;

###########
# SUBLIME TEXT
###########

  SUBLIME="$HOME/Library/Application Support/Sublime Text 3"
  SUBLIME_PACKAGES="$SUBLIME/Packages/User"

  if ! test -d "$SUBLIME_PACKAGES"; then
    echo "Create Sublime Text 3 directory";
    mkdir -p "$SUBLIME_PACKAGES";
  fi;

  # Package Control
  INSTALLED_PACKAGES="$SUBLIME/Installed Packages"
  if ! test -f "$INSTALLED_PACKAGES/Package Control.sublime-package"; then
    echo "Downloading Package Control.sublime-package...";
    curl "https://packagecontrol.io/Package%20Control.sublime-package" --output "$INSTALLED_PACKAGES/Package Control.sublime-package" &>/dev/null;
  fi;

  for FILE in 'Package Control.sublime-settings' 'Preferences.sublime-settings'; do
    rm "$SUBLIME_PACKAGES/$FILE" 2>/dev/null
    ln -sf "$DIR/_external/sublime-text-3/$FILE" "$SUBLIME_PACKAGES/$FILE"
  done

fish "$DIR/_scripts/fish.fish"

exit