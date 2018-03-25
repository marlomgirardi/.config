#!/usr/bin/env sh

echo "Install BobTheFish theme..."
fisher omf/theme-bobthefish 1>/dev/null # https://github.com/oh-my-fish/theme-bobthefish

echo "Install z - z tracks the directories you visit. With a combination of frequency and recency, it enables you to jump to the directory in mind."
fisher z 1>/dev/null # https://github.com/fisherman/z

echo "Install upto - Change to a parent directory by its name."
fisher upto 1>/dev/null # https://github.com/fisherman/upto

echo "Install done - A fish plugin to automatically receive notifications when long processes finish."
fisher done 1>/dev/null # https://github.com/fisherman/done

echo "Install brew-completions - 🐟Fish shell completions for 🍺Homebrew"
fisher laughedelic/brew-completions # https://github.com/laughedelic/brew-completions

echo "Install pj - pj allows you to easily jump between your favourite directories in a predictable manner."
fisher omf/pj 1>/dev/null # https://github.com/oh-my-fish/plugin-pj

echo "Install fnm - Fisher node manager."
fisher fnm 1>/dev/null # https://github.com/fisherman/fnm

echo "Install plugin-node-binpath - Automatically add node_modules binaries to PATH."
fisher omf/plugin-node-binpath 1>/dev/null # https://github.com/oh-my-fish/pplugin-node-binpath

# echo "Install plugin-grc - grc Colourizer for some commands."
# fisher omf/plugin-grc 1>/dev/null # https://github.com/oh-my-fish/plugin-grc

# echo "Install plugin-errno-grep - oh-my-fish plugin to search error numbers, labels and messages"
# fisher install Shadowigor/plugin-errno-grep # https://github.com/Shadowigor/plugin-errno-grep