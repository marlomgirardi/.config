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

zstyle ':omz:editor' keymap 'vi'
zstyle ':completion:*' menu select

source "$HOME/.config/zsh/functions/compinit.zsh"

# Antibody
source <(antibody init)
antibody bundle < ~/.config/.setup/backup/terminal/zsh_plugins

# Aliases
source "$HOME/.config/.setup/backup/terminal/.bash_aliases"
source "$HOME/.config/zsh/functions/grc.zsh"

# Theme
STARSHIP_CONFIG=~/.config/.setup/backup/terminal/starship.toml
STARSHIP_CACHE=~/.config/.data/starship/cache
eval "$(starship init zsh)"

# Add local node_modules binaries to path.
export PATH="$PATH:./node_modules/.bin"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/marlom/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
