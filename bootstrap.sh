#!/usr/bin/env bash

set -euo pipefail

readonly DOTFILES="${HOME}/git/lindhe/dotfiles"

pushd ~

echo "Creating ~/.undodir for vim"
mkdir -p ~/.undodir

echo "Creating symlinks …"

ln -fs "${DOTFILES}/.gitconfig" .
ln -fs "${DOTFILES}/.gitignore_global" .
ln -fs "${DOTFILES}/.tmux.conf" .
ln -fs "${DOTFILES}/.xprofile" .
ln -fs "${DOTFILES}/.zshrc" .
ln -fs "${DOTFILES}/.zsh_aliases" .
ln -fs "${DOTFILES}/.zsh_functions" .
ln -fs "${DOTFILES}/.zsh_wsl" .
ln -fs "${DOTFILES}/.zsh_k8s" .
ln -fs "${DOTFILES}/res" .

mkdir -p ~/.config
cd ~/.config/

ln -fs "${DOTFILES}/.config/git/" .
ln -fs "${DOTFILES}/.config/nvim/" .
ln -fs "${DOTFILES}/.config/zsh/" .

popd

#########################     Download latest nvim     #########################
wget -P ~/.local/bin $(curl --silent -H "Accept: application/vnd.github+json" "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -oP '"browser_download_url": "(.*appimage)"' | awk '{ print $2 }' | sed 's/"//g') \
    && chmod +x ~/.local/bin/nvim.appimage \
    && mv ~/.local/bin/nvim.appimage ~/.local/bin/nvim
