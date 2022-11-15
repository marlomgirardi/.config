#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Project
# @raycast.mode silent
# @raycast.packageName Visual Studio Code
#
# Optional parameters:
# @raycast.icon images/vscode.png
# @raycast.argument1 {"type": "text", "placeholder": "Project name"}
#
# Documentation:
# @raycast.description Open project in VSCode
# @raycast.author Marlom Girardi
# @raycast.authorURL https://github.com/marlomgirardi

if ! command -v code &> /dev/null; then
  echo "Configure to open vscode from terminal (https://code.visualstudio.com/docs/setup/mac).";
  exit 1;
fi

PROJECT_DIR=$(zsh -c "z -e $1")

code "$PROJECT_DIR"

echo $PROJECT_DIR
