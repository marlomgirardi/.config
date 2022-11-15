# MacOS

My MacOS setup and configuration 💻

This should be in `~/.config` this way it can always be up to date with new changes.

Even tho each script inside `.setup/scripts` can be executed as its own, check `.setup/install.sh` as there are dependencies needed.

## Structure

This is the structure used for this project.

```
.config/
│
├─ .data/ - All data generated during usage (as much as we can centralize)
├─ .setup/ - All files relative to the automated setup of the OS.
│  ├─  backup/ - All possible backups and used by the script to restore stuff.
│  ├─  scripts/ - A bunch of scripts used to restore the settings.
│  ├─  backup.sh - A generic script to do backup and not forget anything.
│  ├─  install.sh - The main script where all starts.
│  └─  utils.sh - a few things to help during the setup.
│
├─ _external/ - Here we have all files that will be placed in somewere else as a symbolic link.
│  ├─  home/ - All files and directories in here should be in `~/`.
│  └─  ... - The others have specific directories.
│
├─ ... - Files not documented are originaly from `~/.config` folder
│
├─ LICENSE ¯\_(ツ)_/¯
└─ README.md
```

### Homebrew

With homebrew we basically manage as much as possible:

- CLI
- Apps
- Fonts

All can be found within `.setup/backup/Brewfile`

## Install

First, make sure you are logged in into the App Store as some apps are downloaded directly from there.

Some softwares still not compatible with Silicon processors, install rosetta if you see
"Bad CPU type in executable" or similar.

```ssh
softwareupdate --install-rosetta
```

Create SSH key or import the one you have:

```ssh
#
ssh-keygen -t ed25519;

# Give the proper permissions if imported
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

```sh
# Clone
cd ~
git clone git@github.com:marlomgirardi/MacOS.git .config
```

Change `SYSTEM_NAME` to the desired computer name (optional).

```sh
# Install
SYSTEM_NAME=mbp ~/.config/.setup/install.sh
```

## Apple

- `{domain}` - Is like `com.apple.dock`.
- `{plist}` - Is like `com.apple.dock.plist`. It can e a binary or a xml.

### Most used commands

- `sudo find / -name "*.plist" | grep -v -E "(Info|version).plist" > plist.txt` - Find all plist files except `Info` and `version`
- `osascript -e 'id of app "####"'` - Find #### id to change the defaults
- `defaults domains` - See all domains
- `defaults import {domain} {plist}` - Import a plist
- `defaults export {domain} {pathToPlist}` - Export a plist
- `plutil -convert xml1 {pathOfPlistToConvert}` - Convert a binary plist to xml, easier to edit.
