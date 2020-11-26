#!/bin/sh

# TODO: Don't know why space have issues when used in function params :/
# to_dock() { echo "{tile-data={file-data={_CFURLString=\"${1}\";_CFURLStringType=${2};};};}"; }
to_dock() { echo "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${1}</string><key>_CFURLStringType</key><integer>${2}</integer></dict></dict></dict>"; }
to_dock_app() { echo $(to_dock "/Applications/$1.app" 0); }
to_dock_app_system() { echo $(to_dock "/System/Applications/$1.app" 0); }
to_dock_folder() { echo $(to_dock "file://$1" 15); }

SYSTEM_NAME="mgmbp"

###############################################################################
# Sharing                                                                     #
###############################################################################

    # Set computer name
    sudo scutil --set ComputerName $SYSTEM_NAME
    sudo scutil --set HostName $SYSTEM_NAME
    sudo scutil --set LocalHostName $SYSTEM_NAME
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $SYSTEM_NAME

###############################################################################
# Desktop & Screen Saver                                                      #
###############################################################################

    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # 1048576 modifier is cmd

    # Hot corners - top right screen corner → Desktop
    defaults write com.apple.dock wvous-tr-corner -int 4;
    defaults write com.apple.dock wvous-tr-modifier -int 1048576;
    # Hot corners - bottom right corner -> start screen saver
    defaults write com.apple.dock wvous-br-corner -int 5;
    defaults write com.apple.dock wvous-br-modifier -int 1048576;
    # Hot corners - bottom left corner -> show application window
    defaults write com.apple.dock wvous-bl-corner -int 3;
    defaults write com.apple.dock wvous-bl-modifier -int 1048576;

    # Require password after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1;
    defaults write com.apple.screensaver askForPasswordDelay -int 0;

    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName "Blue Screen Saver" \
        path "$HOME/Library/Screen Savers/Blue Screen Saver.saver" \
        type 0;

###############################################################################
# Screenshots                                                                 #
###############################################################################

    # Save screenshots to the desktop
    defaults write com.apple.screencapture location -string "${HOME}/Desktop";

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png";

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true;

    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 2;

    # Enable HiDPI display modes (requires restart)
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true;

###############################################################################
# Mail                                                                        #
###############################################################################

    # See attachments as icon by default.
    defaults write com.apple.mail DisableInlineAttachmentViewing -bool true;

###############################################################################
# Terminal                                                                    #
###############################################################################

    # Only use UTF-8 in Terminal.app
    defaults write com.apple.terminal StringEncodings -array 4;

###############################################################################
# Finder                                                                      #
###############################################################################

    defaults write com.apple.finder WarnOnEmptyTrash -bool false; # Disable the warning before emptying the Trash
    # defaults write com.apple.finder FavoriteTagNames -array; # clear favorite tag list
    # defaults write com.apple.finder AppleShowAllFiles -bool true; # show hidden files
    defaults write com.apple.finder ShowStatusBar -bool true; # show status bar
    defaults write com.apple.finder ShowPathbar -bool true; # show path bar
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; # show full path
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false; # hide hard drives on desktop
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true; # show media on desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true; # show external drives on desktop
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true; # show servers on desktop

    defaults write com.apple.finder FXRecentFolders -array; # clean recents list
    defaults write com.apple.finder NewWindowTarget -string "PfHm"; # New window to home
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"; # search in current folder

    # Use list view in all Finder windows by default
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
    defaults write com.apple.finder FXPreferredViewStyle -string clmv; # show finder list in columns

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

    # disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false;

    # Avoid creating .DS_Store files on USB and Network Drives
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true;
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;

###############################################################################
# Dock                                                                        #
###############################################################################

    defaults write com.apple.dock persistent-apps -array; # remove icons in Dock
    defaults write com.apple.dock persistent-others -array; # remove folders in Dock
    defaults write com.apple.dock tilesize -int 36; # smaller icon sizes in Dock
    defaults write com.apple.dock autohide -bool false; # turn Dock auto-hiding of
    defaults write com.apple.dock autohide-delay -float 0; # remove Dock show delay
    defaults write com.apple.dock autohide-time-modifier -float 0; # remove Dock show delay
    defaults write com.apple.dock orientation bottom; # place Dock on the bottom of screen
    defaults write com.apple.dock magnification -bool false; # Magnification
    defaults write com.apple.dock minimize-to-application -bool true; # Minimize windows into application icon
    defaults write com.apple.dock launchanim -int 0; # Do not animate opening applications
    defaults write com.apple.dock springboard-columns -int 10; # columns on launchpad
    defaults write com.apple.dock springboard-rows -int 5; # rows on launchpad
    defaults write com.apple.dock ResetLaunchPad -bool true; # restart order in launch
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true; # spring loading for all Dock items
    defaults write com.apple.dock show-process-indicators -bool true;  # indicator lights for open applications in the Dock
    defaults write com.apple.dock show-recents -bool false; # Show recent apps in dock


    # Add apps to dock
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "Launchpad");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Spark");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Safari");

    APP="Google Chrome";
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

    APP="Firefox Developer Edition";
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Spotify");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Slack");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "iTerm");

    APP="Visual Studio Code";
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

    #APP="Sequel Pro";
    #defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

    # defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Cyberduck");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "Notes");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "FaceTime");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "Messages");

    # Add folders to docker
    defaults write com.apple.dock persistent-others -array-add $(to_dock_folder "${HOME}/Library/Projects/");
    defaults write com.apple.dock persistent-others -array-add $(to_dock_folder "${HOME}/Downloads/");

###############################################################################
# Trackpad                                                                    #
###############################################################################

    # Tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false;
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -bool false;

    # Three finger drag
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 0;
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2;
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2;

    # App Exposé swipe down with four fingers
    defaults write com.apple.dock showAppExposeGestureEnabled -int 1;

    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true;

    # Automatically illuminate built-in MacBook keyboard in low light
    defaults write com.apple.BezelServices kDim -bool true;

    # Turn off keyboard illumination when computer is not used for 5 minutes
    defaults write com.apple.BezelServices kDimTime -int 300;

###############################################################################
# Sound                                                                       #
###############################################################################

    # Sound effects on boot
    sudo nvram SystemAudioVolume=%00;

    # User interface sound effects
    defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -bool true;

    # Feedback when volume is changed
    defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 0;

###############################################################################
# General                                                                     #
###############################################################################

    # Enable Firewall
    # sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

    defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
    defaults write NSGlobalDomain AppleInterfaceStyle -string Dark; # use dark theme
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true; # spell auto fix

###############################################################################
# SSD                                                                         #
###############################################################################

    # Disable the sudden motion sensor as it’s not useful for SSDs
    sudo pmset -a sms 0

###############################################################################
# Siri                                                                        #
###############################################################################

    defaults write com.apple.Siri StatusMenuVisible -bool false;

###############################################################################
# Control Center                                                              #
###############################################################################

    defaults write com.apple.controlcenter "NSStatusItem Visible BentoBox" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible Clock" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool false;
    defaults write com.apple.controlcenter "NSStatusItem Visible UserSwitcher" -bool false;
    defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool false;

###############################################################################
# Web                                                                         #
###############################################################################

    # Privacy: don’t send search queries to Apple
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true

    # Show the full URL in the address bar (note: this still hides the scheme)
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

    # Set Safari’s home page to `about:blank` for faster loading
    defaults write com.apple.Safari HomePage -string "about:blank"

    # Cmd-f should find stuff anywhere in the page, just as in Chrome
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false;

    # Enable Safari’s debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Enable the Develop menu and the Web Inspector in Safari
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

    # Enable continuous spellchecking
    defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

    # Disable auto-correct
    defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

    # Warn about fraudulent websites
    defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

    # Disable Java
    defaults write com.apple.Safari WebKitJavaEnabled -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

    # Add a context menu item for showing the Web Inspector in webviews
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true;

    # Block pop-up windows
    defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

###############################################################################
# System UI Server                                                            #
###############################################################################

    defaults write com.apple.systemuiserver menuExtras -array \
        "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
        "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
        "/System/Library/CoreServices/Menu Extras/Volume.menu";

###############################################################################
# Plists to import                                                            #
###############################################################################

    PLISTS=$(/bin/ls "$HOME/.config/_backup/plists/" | sed -e "s/\.plist//")

    for PLIST in $PLISTS; do
        echo "Import $PLIST defaults...";
        defaults import $PLIST "$HOME/.config/_backup/plists/$PLIST.plist";
    done;

if [ $SHELL != "/usr/local/bin/fish" ]; then
	echo "Defined fish as default shell...";
   echo "/usr/local/bin/fish" | sudo tee -a /etc/shells;
   chsh -s /usr/local/bin/fish;
fi

killall Spotlight; # Restart Spotlight
killall ControlCenter; # Restart Control Center
killall ControlStrip; # Restart Touchbar
killall Dock; # Restart Dock
killall Finder; # Restart Finder
killall SystemUIServer; # Restart Top right menu (clock, battery, ...)
