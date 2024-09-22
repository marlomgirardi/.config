#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decode JWT
# @raycast.mode fullOutput
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon images/jwt-logo.png

# Documentation:
# @raycast.description Decodes JSON web token from the clipboard.

jwt-decode() {
  # We can't use the simple @base64d due to jq not handling web-safe encoded base64: https://github.com/jqlang/jq/issues/2262
  # jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
  jq -R 'split(".") |.[0:2] | map(gsub("-"; "+") | gsub("_"; "/") | gsub("%3D"; "=") | @base64d) | map(fromjson)'
}

jwt-decode $(pbpaste)