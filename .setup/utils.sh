exists() { hash $1 2>/dev/null; }
not_exists() { ! exists $1; }

to_dock() { echo "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${1}</string><key>_CFURLStringType</key><integer>${2}</integer></dict></dict></dict>"; }
to_dock_app() { echo $(to_dock "/Applications/$1.app" 0); }
to_dock_app_system() { echo $(to_dock "/System/Applications/$1.app" 0); }
to_dock_folder() { echo $(to_dock "file://$1" 15); }
