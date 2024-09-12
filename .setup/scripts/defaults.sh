#!/bin/sh

###############################################################################
# Sharing                                                                     #
###############################################################################

if [[ -v SYSTEM_NAME ]]; then
    # Set computer name
    sudo scutil --set ComputerName $SYSTEM_NAME
    sudo scutil --set HostName $SYSTEM_NAME
    sudo scutil --set LocalHostName $SYSTEM_NAME
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $SYSTEM_NAME
fi

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

    # Hot corners - top left corner -> put display to sleep
    defaults write com.apple.dock wvous-tl-corner -int 10;
    defaults write com.apple.dock wvous-tl-modifier -int 1048576;

    # Hot corners - bottom left corner -> start screen saver
    defaults write com.apple.dock wvous-bl-corner -int 5;
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
    defaults write "Apple Global Domain" AppleFontSmoothing -int 2;

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
    defaults delete com.apple.finder FavoriteTagNames; # clear favorite tag list
    defaults write com.apple.finder AppleShowAllFiles -bool true; # show hidden files
    defaults write com.apple.finder ShowStatusBar -bool true; # show status bar
    defaults write com.apple.finder ShowSidebar -bool true; # showsidebar 
    defaults write com.apple.finder ShowPathbar -bool true; # show path bar
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; # show full path
    defaults write com.apple.finder _FXSortFoldersFirst -bool true; # Folders at the top
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
    defaults write com.apple.Dock showhidden -bool true; # Show hidden apps in dock (Cmd + H)


    # Add apps to dock
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Spark");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Arc");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Safari");

    APP="Brave Browser";
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";


    APP="Firefox Developer Edition";
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Spotify");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Slack");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Warp");

    APP="Visual Studio Code";
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";

    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "TablePlus");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Notion");


    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "Freeform");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "Notes");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "Messages");

    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app "Figma");
    defaults write com.apple.dock persistent-apps -array-add $(to_dock_app_system "iPhone Mirroring");

    # Add folders to docker
    defaults write com.apple.dock persistent-others -array-add $(to_dock_folder "${HOME}/Library/Projects/");
    defaults write com.apple.dock persistent-others -array-add $(to_dock_folder "${HOME}/Downloads/");

###############################################################################
# Trackpad                                                                    #
###############################################################################

    # Tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false;
    defaults -currentHost write "Apple Global Domain" com.apple.mouse.tapBehavior -bool false;

    # Three finger drag
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 0;
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2;
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2;

    # App Exposé swipe down with four fingers
    defaults write com.apple.dock showAppExposeGestureEnabled -int 1;

    # Automatically illuminate built-in MacBook keyboard in low light
    defaults write com.apple.BezelServices kDim -bool true;

    # Turn off keyboard illumination when computer is not used for 5 minutes
    defaults write com.apple.BezelServices kDimTime -int 300;

###############################################################################
# Sound                                                                       #
###############################################################################

    # Sound effects on boot
    sudo nvram SystemAudioVolume=%00;

    # Feedback when volume is changed
    defaults write "Apple Global Domain" com.apple.sound.beep.feedback -int 0;

###############################################################################
# General                                                                     #
###############################################################################

    # Enable Firewall
    # sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

    defaults write "Apple Global Domain" AppleShowAllExtensions -bool true; # show all file extensions
    defaults write "Apple Global Domain" AppleInterfaceStyle -string Dark; # use dark theme
    defaults write "Apple Global Domain" NSAutomaticSpellingCorrectionEnabled -bool true; # spell auto fix
    defaults write "Apple Global Domain" AppleMenuBarVisibleInFullscreen -bool true;  # Always show menu bar on full screen
    defaults write "Apple Global Domain" AppleSpacesSwitchOnActivate -bool true;  # Always show menu bar on full screen

    # Test: Disable Spotlight Command + Space
    # https://superuser.com/questions/1211108/remove-osx-spotlight-keyboard-shortcut-from-command-line
    # defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
    #     '{
    #         enabled = false;
    #         value = {
    #             parameters = (
    #                 32,
    #                 49,
    #                 1048576
    #             );
    #             type = standard;
    #         };
    #     }'

###############################################################################
# Siri                                                                        #
###############################################################################

    defaults write com.apple.Siri StatusMenuVisible -bool true;
    defaults write com.apple.Siri TypeToSiriEnabled -bool true;

###############################################################################
# Control Center                                                              #
###############################################################################

    defaults write com.apple.controlcenter "NSStatusItem Visible BentoBox" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible Clock" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible Shortcuts" -bool true;
    defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool false;
    defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool false;
    defaults write com.apple.controlcenter "NSStatusItem Visible UserSwitcher" -bool false;
    defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool false;
    defaults write com.apple.controlcenter "NSStatusItem Visible Spotlight" -bool false;
    defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool true;

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
    defaults write "Apple Global Domain" WebKitDeveloperExtras -bool true;

    # Block pop-up windows
    defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

###############################################################################
# VS Code                                                                     #
###############################################################################

    # Only worked ater this reset
    defaults delete -g ApplePressAndHoldEnabled

    # Repeat delay and speed
    defaults write "Apple Global Domain" InitialKeyRepeat -int 15
    defaults write "Apple Global Domain" KeyRepeat -int 2

    # Repeated keys for vim keybindings
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

###############################################################################
# Plists to import                                                            #
###############################################################################

    PLISTS=$(/bin/ls "$SETUP_DIR/backup/plists/" | sed -e "s/\.plist//")

    for PLIST in $PLISTS; do
        echo "Import $PLIST defaults...";
        defaults import $PLIST "$SETUP_DIR/backup/plists/$PLIST.plist";
    done;

killall ControlCenter; # Restart Control Center
killall Dock; # Restart Dock
killall Finder; # Restart Finder
killall SystemUIServer; # Restart Top right menu (clock, battery, ...)

# As we remove spotlight, trigger raycast to start.
open /Applications/Raycast.app
