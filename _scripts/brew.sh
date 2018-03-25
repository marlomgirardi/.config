#!/bin/sh

echo "Update brew..." && brew update 1>/dev/null
echo "Upgrade brew packages..." && brew upgrade 1>/dev/null
echo "Clear old versions..." && brew cleanup -s 1>/dev/null