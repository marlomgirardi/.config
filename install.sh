#!/bin/bash

# If not exists, install Homebrew
if ! hash brew 2>/dev/null; then
  echo "You will need Homebrew installed"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# If not exists, install coreutils with brew command
if ! hash gls 2>/dev/null; then
  echo "You will need coreutils installed"
  brew install coreutils
fi

# If not exists, install colordiff with brew command
if ! hash colordiff 2>/dev/null; then
  echo "Colordiff will be installed"
  brew install colordiff
fi

# If not exists, install fzf with brew command
if ! hash fzf 2>/dev/null; then
  echo "fzf will be installed"
  brew install fzf
fi

# If not exists, install fzf with brew command
if ! hash pstree 2>/dev/null; then
  echo "pstree will be installed"
  brew install pstree
fi

# If not exists, install fzf with brew command
if ! hash nvm 2>/dev/null; then
  echo "nvm will be installed"
  brew install nvm
fi

# Get instalation folder
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

# Create Links
ln -sf $DIR/bash/.bashrc $HOME/.bashrc
ln -sf $DIR/bash/.vimrc $HOME/.vimrc
ln -sf $DIR/bash/.vim ~/.vim

# Temp fix
rm $DIR/bash/.vim/.vim 2>/dev/null

source $HOME/.bashrc
