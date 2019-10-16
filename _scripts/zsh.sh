# Install Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# https://github.com/starship/starship
brew install starship

# Theme
# git clone git://github.com/denysdovhan/spaceship-prompt $ZSH/themes/spaceship-prompt
# ln -s $ZSH/themes/spaceship-prompt/spaceship.zsh-theme $ZSH/themes/spaceship.zsh-theme

# Fish-like fast/unobtrusive autosuggestions for zsh.
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH}/plugins/zsh-autosuggestions

# This is a clean-room implementation of the Fish shell's history search feature
git clone git://github.com/zsh-users/zsh-history-substring-search ${ZSH}/plugins/zsh-history-substring-search

# Fish shell-like syntax highlighting for Zsh.
git clone git://github.com/zsh-users/zsh-syntax-highlighting ${ZSH}/plugins/zsh-syntax-highlighting

# 4. Fix background theme issues (Not necessary depends on your theme)
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

# Restart zsh
source ~/.zshrc