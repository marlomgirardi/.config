#!/bin/bash

# Get instalation folder
DIR=$( cd -P $( dirname $BASH_SOURCE[0] ) && pwd )

# Create Links
ln -sf $DIR/bash/.bashrc ~/.bashrc
ln -sf $DIR/bash/.vim ~/.vim
ln -sf $DIR/bash/.vimrc ~/.vimrc

source ~/.bashrc
