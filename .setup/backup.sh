#!/bin/bash

# dir from this script
SETUP_DIR=$(cd $(dirname $BASH_SOURCE) && pwd)

# dump into Brewfile
brew bundle dump --force;

# Run scripts
PLISTS="com.apple.controlcenter com.dwarvesv.minimalbar cc.ffitch.shottr com.sindresorhus.Velja";

for PLIST in $PLISTS; do
    defaults export $PLIST "$SETUP_DIR/backup/plists/$PLIST.plist"
    plutil -convert xml1 "$SETUP_DIR/backup/plists/$PLIST.plist"
done
