#!/bin/bash

# Get instalation folder
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

# Create Links
ln -sf $DIR/bash/.bashrc $HOME/.bashrc
ln -sf $DIR/bash/.vimrc $HOME/.vimrc
ln -sf $DIR/bash/.vim ~/.vim

# Temp fix
rm $DIR/bash/.vim/.vim

source $HOME/.bashrc
