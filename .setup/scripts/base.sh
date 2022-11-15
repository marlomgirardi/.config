#!/bin/bash

#####
# Install Xcode Command Line
#####

# https://stackoverflow.com/questions/15371925/how-to-check-if-command-line-tools-is-installed
# https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
if not_exists gcc; then
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
  softwareupdate -i "$PROD" -a
fi;

# Screen Saver
# https://github.com/dessibelle/Blue-Screen-Saver
if ! test -d "$HOME/Library/Screen Savers/Blue Screen Saver.saver"; then
    echo "Copy screen saver...";
    curl "https://www.dropbox.com/s/30upmkpsdkyvjug/Blue-Screen-Saver.saver.zip?dl=1" -sLo "/tmp/saver.zip" 1>/dev/null;
    unzip /tmp/saver.zip -d "$HOME/Library/Screen Savers/"
fi;

######
# Custom directories
######

if ! test -d "$HOME/Library/Projects/"; then
  echo "Create Projects directory ...";
  mkdir "$HOME/Library/Projects/";
fi;
