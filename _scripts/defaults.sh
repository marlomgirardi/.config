#!/bin/sh

# TODO: Don't know why space have issues when used in function params :/
to_dock() { echo "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>$2</integer></dict></dict></dict>"; }
to_dock_app() { echo $(to_dock "/Applications/$1.app" 0); }
to_dock_folder() { echo $(to_dock "file://$1" 15); }

#####
# Terminal
#####

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4;


#####
# Finder
#####

defaults write com.apple.finder FavoriteTagNames -array; # clear favorite tag list
defaults write com.apple.finder AppleShowAllFiles -bool true; # show hidden files
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false; # hide hard drives on desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true; # show media on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true; # show external drives on desktop
defaults write com.apple.finder FXPreferredViewStyle -string clmv; # show finder list in columns
defaults write com.apple.finder FXRecentFolders -array; # clean recents list
defaults write com.apple.finder NewWindowTarget -string "PfHm"; # New window to home
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"; # search in current folder

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false;

# Avoid creating .DS_Store files on USB and Network Drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true;
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;


#####
# Dock
#####

defaults write com.apple.dock persistent-apps -array; # remove icons in Dock
defaults write com.apple.dock persistent-others -array; # remove folders in Dock

defaults write com.apple.dock tilesize -int 36; # smaller icon sizes in Dock
defaults write com.apple.dock autohide -bool false; # turn Dock auto-hiding of
defaults write com.apple.dock autohide-delay -float 0; # remove Dock show delay
defaults write com.apple.dock autohide-time-modifier -float 0; # remove Dock show delay
defaults write com.apple.dock orientation bottom; # place Dock on the bottom of screen

defaults write com.apple.dock springboard-columns -int 10; # columns on launchpad
defaults write com.apple.dock springboard-rows -int 5; # rows on launchpad
defaults write com.apple.dock ResetLaunchPad -bool true;

# Add apps to docker
defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Launchpad");
defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Spark");
defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Safari");

APP="Google Chrome";
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Spotify");
defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Slack");

APP="Visual Studio Code";
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

APP="Sequel Pro";
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Cyberduck");
defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Notes");
defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "FaceTime");
defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Messages");

# Add folders to docker
defaults write com.apple.dock persistent-others -array-add $(to_dock_folder "/Users/$USER/Library/Projects/");
defaults write com.apple.dock persistent-others -array-add $(to_dock_folder "/Users/$USER/Downloads/");


#####
# General
#####

defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark; # use dark theme
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true;

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true;
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144;
defaults write com.apple.screencapture disable-shadow -bool true; # Disable shadow in PRT SCR


#####
# Siri
#####

defaults write com.apple.Siri StatusMenuVisible -bool false;

killall Dock; # Restart Dock
killall Finder; # Restart Finder
killall SystemUIServer; # Restart Top right menu (clock, battery, ...)

#####
# Plists to import
#####

echo "Import iTerm defaults...";
defaults import com.googlecode.iterm2 $1/_backup/plists/com.googlecode.iterm2.plist;

if [ $SHELL != "/usr/local/bin/fish" ]; then
	echo "Defined fish as default shell...";
    echo "/usr/local/bin/fish" | sudo tee -a /etc/shells;
    chsh -s /usr/local/bin/fish;
fi

# com.apple.Siri
# com.apple.Dataclass.Contacts
# com.apple.Dataclass.Bookmarks
# com.apple.Dataclass.Siri
# MobileMeAccounts
# com.apple.systempreferences

# WindowServer
# Terminal
# TouchBarServer
# Menu Extras
# CoreServicesUIAgent
# Spotlight
# LocationMenu

# NotificationCenter
