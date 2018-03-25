#!/bin/sh

echo "Import iTerm defaults..." && defaults import com.googlecode.iterm2 $1/_plists/com.googlecode.iterm2.plist

if [ $SHELL != "/usr/local/bin/fish" ]; then
	echo "Defined fish as default shell..." && echo "/usr/local/bin/fish" | sudo tee -a /etc/shells && chsh -s /usr/local/bin/fish
fi
