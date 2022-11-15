#!/bin/bash

# dir from this script
export SETUP_DIR=$(cd $(dirname $BASH_SOURCE) && pwd)

. $SETUP_DIR/utils.sh

# Ask for the administrator password
sudo -v;


# ###########
# # INSTALLATION SCRIPTS
# ###########

for SCRIPT in base homebrew ruby sublime-text terminal defaults; do
  . $SETUP_DIR/scripts/$SCRIPT.sh
done

source ~/.zshrc
