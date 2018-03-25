#!/bin/sh

# Get instalation folder
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

# Run scripts
for SCRIPT in installation defaults brew; do
	sh "$DIR/_scripts/$SCRIPT.sh" $DIR
done

# Create Links into ~/
for FILE in vim vimrc; do
  rm "$HOME/.$FILE" 2>/dev/null
  ln -sf "$DIR/_profile/.$FILE" $HOME
done

source "$HOME/.profile"

echo "Execute 'fish' and after '_scripts/fish.sh'"

exit