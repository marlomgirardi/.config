# Interactive shells only. Options, completion, plugins, prompt, aliases.

# Non-login terminals (Cursor, VS Code, etc.) skip .zprofile — load PATH/brew.
if [[ ! -o login ]]; then
  source "$HOME/.config/zsh/.zprofile_local"
fi
BREW_DIR="$(brew --prefix)"
setopt HIST_IGNORE_SPACE
export HISTORY_IGNORE='(ls|history|pwd|clear|c)'
export GPG_TTY="$(tty)"

zstyle ':omz:editor' keymap 'vi'
zstyle ':completion:*' menu select

source "$HOME/.config/zsh/functions/compinit.zsh"

# antidote
source "$BREW_DIR/opt/antidote/share/antidote/antidote.zsh"
antidote load ~/.config/.setup/backup/terminal/zsh_plugins

# Theme
export STARSHIP_CONFIG=~/.config/.setup/backup/terminal/starship.toml
eval "$(starship init zsh)"

# Aliases
source "$HOME/.config/.setup/backup/terminal/.bash_aliases"

# Landing directory for new shells started in $HOME.
if [[ "$(pwd)" == "$HOME" ]]; then
  cd "$HOME/Library/Projects"
fi

# Local node_modules binaries (cwd-relative; interactive only).
export PATH="$PATH:./node_modules/.bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_DIR/opt/nvm/nvm.sh" ] && . "$BREW_DIR/opt/nvm/nvm.sh"
[ -s "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm"

export FPATH="$BREW_DIR/opt/eza/completions/zsh:$FPATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
