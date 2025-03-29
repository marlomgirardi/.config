export GEM_HOME="$HOME/.config/.data/gem";
export HOMEBREW_BUNDLE_FILE="$HOME/.config/.setup/backup/Brewfile";

eval "$(/opt/homebrew/bin/brew shellenv)"


# Ignore from history if command start with "<space>"
setopt HIST_IGNORE_SPACE

LC_ALL=en_US.UTF-8
EDITOR=vim
VISUAL='code --wait'
GIT_EDITOR=vim
GPG_TTY=$(tty)
HISTORY_IGNORE='(ls|history|pwd|clear|c)'
BREW_DIR=$(brew --prefix)

zstyle ':omz:editor' keymap 'vi'
zstyle ':completion:*' menu select

source "$HOME/.config/zsh/functions/compinit.zsh"

# antidote
source $BREW_DIR/opt/antidote/share/antidote/antidote.zsh
antidote load ~/.config/.setup/backup/terminal/zsh_plugins

# Aliases
source "$HOME/.config/.setup/backup/terminal/.bash_aliases"

# Theme
STARSHIP_CONFIG=~/.config/.setup/backup/terminal/starship.toml
STARSHIP_CACHE=~/.config/.data/starship/cache
eval "$(starship init zsh)"

# For any app the landing will be the Projects folder instead of the home folder.
if [[ $(pwd) == $HOME ]]; then
  cd $HOME/Library/Projects
fi

# Add local node_modules binaries to path.
export PATH="$PATH:./node_modules/.bin"

export NVM_DIR="$HOME/.nvm"
  [ -s "$BREW_DIR/opt/nvm/nvm.sh" ] && \. "$BREW_DIR/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


export FPATH="$BREW_DIR/opt/eza/completions/zsh:$FPATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
