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
ln -fs ~/git/lindhe/dotfiles/res .

mkdir -p ~/.config
cd ~/.config/

ln -fs ~/git/lindhe/dotfiles/.config/nvim/ .
ln -fs ~/git/lindhe/dotfiles/.config/zsh/ .

popd

