#!/usr/bin/env bash

set -euo pipefail

pushd ~

echo "Creating ~/.undodir for vim"
mkdir -p ~/.undodir

echo "Creating symlinks …"

ln -s ~/git/lindhe/dotfiles/.gitconfig .
ln -s ~/git/lindhe/dotfiles/.gitignore_global .
ln -s ~/git/lindhe/dotfiles/.tmux.conf .
ln -s ~/git/lindhe/dotfiles/.xprofile .
ln -s ~/git/lindhe/dotfiles/.zshrc .
ln -s ~/git/lindhe/dotfiles/res .

mkdir -p ~/.config
cd ~/.config/

ln -s ~/git/lindhe/dotfiles/.config/nvim/ .
ln -s ~/git/lindhe/dotfiles/.config/zsh/ .

popd

