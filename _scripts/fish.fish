#!/usr/bin/env sh

echo "Install z - z tracks the directories you visit. With a combination of frequency and recency, it enables you to jump to the directory in mind."
omf install z 1>/dev/null # https://github.com/jethrokuan/z

echo "Install pj - pj allows you to easily jump between your favourite directories in a predictable manner."
omf install pj 1>/dev/null # https://github.com/oh-my-fish/plugin-pj

echo "Install plugin-node-binpath - Automatically add node_modules binaries to PATH."
omf install node-binpath 1>/dev/null # https://github.com/oh-my-fish/plugin-node-binpath

echo "Install plugin-grc - grc Colourizer for some commands."
omf install grc 1>/dev/null # https://github.com/oh-my-fish/plugin-grc

echo "Install starship theme..."
brew install starship

# echo "Install plugin-errno-grep - oh-my-fish plugin to search error numbers, labels and messages"
# fisher install Shadowigor/plugin-errno-grep # https://github.com/Shadowigor/plugin-errno-grep
