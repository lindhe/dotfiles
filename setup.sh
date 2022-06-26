#!/usr/bin/env bash

ready="n"
while [[ $ready != 'y' ]]; do
    echo -e "\nHave you cloned into ~/git/lindhe/dotfiles/? (y/n)"
    read -n 1 ready
done;

pushd ~

echo "Creating ~/.undodir for vim"
mkdir -p ~/.undodir

echo "Creating symlinks in ~/"
ln -s ~/git/lindhe/dotfiles/.vimrc .
ln -s ~/git/lindhe/dotfiles/.vim .
ln -s ~/git/lindhe/dotfiles/.zshrc .
ln -s ~/git/lindhe/dotfiles/.xprofile .
ln -s ~/git/lindhe/dotfiles/.tmux.conf .
ln -s ~/git/lindhe/dotfiles/res .
ln -s ~/git/lindhe/dotfiles/.gitignore_global .
ln -s ~/git/lindhe/dotfiles/.gitconfig .

echo "Creating symlinks in ~/.config/"
mkdir -p ~/.config
pushd ~/.config/
ln -s ~/git/lindhe/dotfiles/.config/compton.conf .
ln -s ~/git/lindhe/dotfiles/.config/dunst/ .
ln -s ~/git/lindhe/dotfiles/.config/i3 .
ln -s ~/git/lindhe/dotfiles/.config/i3blocks/ .
ln -s ~/git/lindhe/dotfiles/.config/nvim/ .
ln -s ~/git/lindhe/dotfiles/.config/monitors/ .
ln -s ~/git/lindhe/dotfiles/.config/sway .
ln -s ~/git/lindhe/dotfiles/.config/zathura/ .
ln -s ~/git/lindhe/dotfiles/.config/zsh/ .
popd

echo "Installing custom keyboard layouts"
sudo cp ~/git/lindhe/dotfiles/usr/share/X11/xkb/symbols/* -t /usr/share/X11/xkb/symbols

popd
