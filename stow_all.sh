#!/bin/bash

stow --dotfiles -t $HOME nvim
stow --dotfiles -t $HOME zshrc
stow --dotfiles -t $HOME tmux
stow --dotfiles -t $HOME ghostty
stow --dotfiles -t $HOME gnome
dconf load / < ~/.config/dconf/dconf-settings.ini
