#!/bin/bash

DIR=$1
DB=$(find /private/var/folders -user $(id -u) -name com.apple.dock.launchpad 2> /dev/null)/db/db

defaults write com.apple.dock ResetLaunchPad -bool true;
killall Dock; # Restart Dock

sleep 2;

sqlite3 $DB < $1/_scripts/launchpad.sql;

killall Dock; # Restart Dock
