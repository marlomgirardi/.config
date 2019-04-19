#!/bin/sh

# Ask for the administrator password
sudo -v;

# dir from this script (.config)
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

# Get instalation folder
# VSCODE='/Users/marlom/Library/Application Support/Code/User'
# Run scripts
for SCRIPT in installation defaults; do
	$DIR/_scripts/$SCRIPT.sh $DIR
done

# # Create Links into ~/
# for FILE in vim vimrc; do
#   rm "$HOME/.$FILE" 2>/dev/null
#   ln -sf "$DIR/_profile/.$FILE" $HOME
# done

# # Create Links into VS Code directory
# for FILE in 'settings.json' 'keybinding.json'; do
#   rm "$VSCODE/$FILE" 2>/dev/null
#   ln -sf "$DIR/.vscode/$FILE" $HOME
# done

# source "$HOME/.profile"

# echo "Execute 'fish' and after '_scripts/fish.sh'"

exit