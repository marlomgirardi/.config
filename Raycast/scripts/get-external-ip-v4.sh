#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title External IPv4
# @raycast.mode inline
# @raycast.refreshTime 24h
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Copies the external IPv4 to the clipboard.

ip=$(curl -4 -s -m 5 https://api.ipify.org)
echo $ip