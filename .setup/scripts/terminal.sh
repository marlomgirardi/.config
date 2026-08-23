#!/bin/bash

# Installers grep-and-append ~/.zshrc and ~/.zprofile. Those must be the
# gitignored *_local files (which source the tracked originals) so writes
# never show up in git status. Do not symlink the tracked files into $HOME.
#
# Layout: .zshenv (always) → .zprofile (login/PATH) → .zshrc (interactive).
[ -f ~/.config/zsh/.zshrc_local ] || echo 'source "$HOME/.config/zsh/.zshrc"' > ~/.config/zsh/.zshrc_local
[ -f ~/.config/zsh/.zprofile_local ] || echo 'source "$HOME/.config/zsh/.zprofile"' > ~/.config/zsh/.zprofile_local

ln -sfn ~/.config/zsh/.zshenv ~/.zshenv
ln -sfn ~/.config/zsh/.zprofile_local ~/.zprofile
ln -sfn ~/.config/zsh/.zshrc_local ~/.zshrc


echo $(which zsh) | sudo tee -a /etc/shells;
chsh -s $(which zsh)


# Not a big deal, so it will be here for now
ln -s ~/.config/cargo/config.toml ~/.cargo/config.toml
