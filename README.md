# MacOS

My MacOS setup and configuration 💻

This should be in `~/.config` this way it can always be up to date with new changes.

## Before run the script

1. Login into App Store app.

## Structure

This is the structure used for this project.

```
.config/
│
├─ _backup/ - Here we have our scripts.
│
├─ _external/ - Here we have all files that will be placed in somewere else as a symbolic link.
│  ├─  home/ - All files and directories in here should be in `~/`.
│  └─  ... - The others have specific directories.
│
├─ _scripts/ - Here we have our scripts.
│  ├─  brew.sh - This file install some brew plugins that I use.
│  ├─  defaults.sh - This file configure the defaults of macOS.
│  ├─  fish.sh - This file is responsible to install all fish dependencies, theme and plugins.
│  └─  installation.sh - This file is responsible to install every app and cli that I need.
│
├─ ... - Files not documented are originaly from `~/.config` folder
│
├─ backup.sh - This is responsible to do the backups that we need.
├─ install.sh - This is the main file wich will call all the others.
│
├─ LICENSE ¯\_(ツ)_/¯
└─ README.md
```

## Install

```sh
# Clone
cd ~
git clone --recursive git@github.com:marlomgirardi/MacOS.git .config
```

Change `SYSTEM_NAME` at `defaults.sh`.

```sh
# Install
sh .config/install.sh
```

## Apple

- `{domain}` - Is like `com.apple.dock`.
- `{plist}` - Is like `com.apple.dock.plist`. It can e a binary or a xml.

### Most used commands

- `sudo find / -name "*.plist" | grep -v -E "(Info|version).plist" > plist.txt`  - Find all plist files except `Info` and `version`
- `osascript -e 'id of app "####"'` - Find #### id to change the defaults
- `defaults domains` - See all domains
- `defaults import {domain} {plist}` -  Import a plist
- `defaults export {domain} {pathToPlist}` -  Export a plist
- `plutil -convert xml1 {pathOfPlistToConvert}` - Convert a binary plist to xml, easier to edit.

