#!/bin/sh

# Get instalation folder
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

sh $DIR/_scripts/installation.sh

# Create Links
for a in bash_profile vim vimrc; do
  ln -sf "$DIR/bash/.$a" $HOME
done

source "$HOME/.bash_profile"
