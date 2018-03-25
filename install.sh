#!/bin/sh

# Get instalation folder
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

# Run scripts
for SCRIPT in installation defaults brew; do
	sh "$DIR/_scripts/$SCRIPT.sh" $DIR
done

# Create Links into ~/
for FILE in bash_profile vim vimrc; do
  ln -sf "$DIR/_profile/.$FILE" $HOME
done

source "$HOME/.bash_profile"
