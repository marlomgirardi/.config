#!/bin/bash

ln -s ~/.config/zsh/.zprofile ~/.zprofile
ln -s ~/.config/zsh/.zshrc ~/.zshrc

echo $(which zsh) | sudo tee -a /etc/shells;
chsh -s $(which zsh)
