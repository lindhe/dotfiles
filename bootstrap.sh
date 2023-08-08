#!/usr/bin/env bash

set -euo pipefail

declare -r GIT_DIR="${HOME}/git/lindhe"
declare -r DOTFILES="${GIT_DIR}/dotfiles"
declare -r SCRIPTS="${GIT_DIR}/scripts"

pushd ~

echo "Creating ~/.undodir for vim"
mkdir -p ~/.undodir

echo "Creating symlinks …"

ln -fs "${DOTFILES}/.gitconfig" .
ln -fs "${DOTFILES}/.gitignore_global" .
ln -fs "${DOTFILES}/.tmux.conf" .
ln -fs "${DOTFILES}/.xprofile" .
ln -fs "${DOTFILES}/.yamllint_global.yaml" .yamllint.yaml
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

if [[ ! -d "${SCRIPTS}" ]]; then
  git clone https://github.com/lindhe/scripts.git "${SCRIPTS}"
fi
