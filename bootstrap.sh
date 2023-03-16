#!/usr/bin/env bash

set -euo pipefail

pushd ~

echo "Creating ~/.undodir for vim"
mkdir -p ~/.undodir

echo "Creating symlinks …"

ln -fs ~/git/lindhe/dotfiles/.gitconfig .
ln -fs ~/git/lindhe/dotfiles/.gitignore_global .
ln -fs ~/git/lindhe/dotfiles/.tmux.conf .
ln -fs ~/git/lindhe/dotfiles/.xprofile .
ln -fs ~/git/lindhe/dotfiles/.zshrc .
ln -fs ~/git/lindhe/dotfiles/.zsh_aliases .
ln -fs ~/git/lindhe/dotfiles/.zsh_functions .
ln -fs ~/git/lindhe/dotfiles/.zsh_wsl .
ln -fs ~/git/lindhe/dotfiles/.zsh_k8s .
ln -fs ~/git/lindhe/dotfiles/res .

mkdir -p ~/.config
cd ~/.config/

ln -fs ~/git/lindhe/dotfiles/.config/git/ .
ln -fs ~/git/lindhe/dotfiles/.config/nvim/ .
ln -fs ~/git/lindhe/dotfiles/.config/zsh/ .

popd

#########################     Download latest nvim     #########################
wget -P ~/.local/bin $(curl --silent -H "Accept: application/vnd.github+json" "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -oP '"browser_download_url": "(.*appimage)"' | awk '{ print $2 }' | sed 's/"//g') \
    && chmod +x ~/.local/bin/nvim.appimage \
    && mv ~/.local/bin/nvim.appimage ~/.local/bin/nvim
