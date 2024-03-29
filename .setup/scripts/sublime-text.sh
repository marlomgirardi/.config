#!/bin/bash

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
  ln -sf "$SETUP_DIR/backup/sublime-text-3/$FILE" "$SUBLIME_PACKAGES/$FILE"
done
