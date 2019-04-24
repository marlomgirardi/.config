#!/bin/sh

# Get instalation folder
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

PLISTS="com.googlecode.iterm2 com.crystalidea.macsfancontrol ch.sudo.cyberduck";

# Run scripts
for PLIST in $PLISTS; do
	defaults export $PLIST "$DIR/_backup/plists/$PLIST.plist"
	plutil -convert xml1 "$DIR/_backup/plists/$PLIST.plist"
done

# Backup vs code extensions
"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" --list-extensions > "$DIR/_external/vscode/extensions"