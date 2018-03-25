#!/bin/sh

# Get instalation folder
DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )

PLISTS="com.apple.finder com.apple.dock"

# Run scripts
for PLIST in $PLISTS; do
	defaults read $PLIST > "$DIR/_plists/$PLIST.plist"
done