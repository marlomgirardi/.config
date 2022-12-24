#!/bin/bash

ln -s ~/.config/zsh/.zshenv ~/.zshenv
ln -s ~/.config/zsh/.zprofile ~/.zprofile
ln -s ~/.config/zsh/.zshrc ~/.zshrc

echo $(which zsh) | sudo tee -a /etc/shells;
chsh -s $(which zsh)


# Not a bit deal, so it will be here for now
ln -s ~/.config/cargo/config.toml ~/.cargo/config.toml
