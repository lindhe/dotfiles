#!/usr/bin/env bash

set -euo pipefail

declare -r GIT_DIR="${HOME}/git/lindhe"

declare -r DOTFILES="${GIT_DIR}/dotfiles"
declare -r SCRIPTS="${GIT_DIR}/scripts"

cd ~

echo "Creating ~/.undodir for vim"
mkdir -p ~/.undodir

echo "Creating symlinks …"

ln -fs "${DOTFILES}/.gitconfig" .
ln -fs "${DOTFILES}/.gitignore_global" .
ln -fs "${DOTFILES}/.tool-versions" .
ln -fs "${DOTFILES}/.xprofile" .
ln -fs "${DOTFILES}/.yamllint_global.yaml" .yamllint.yaml
ln -fs "${DOTFILES}/.zsh_aliases" .
ln -fs "${DOTFILES}/.zsh_functions" .
ln -fs "${DOTFILES}/.zsh_k8s" .
ln -fs "${DOTFILES}/.zsh_wsl" .
ln -fs "${DOTFILES}/.zshrc" .
ln -fs "${DOTFILES}/res" .


mkdir -p ~/.config/git

cd ~/.config/git
ln -fs "${DOTFILES}/.config/git/github.gitconfig" .
# If WSL2:
if [[ -n ${WSLENV+x} ]]; then
  ln -fs "${DOTFILES}/.config/git/wsl.gitconfig" .
fi

cd ~/.config
ln -fs "${DOTFILES}/.config/nvim/" .
ln -fs "${DOTFILES}/.config/tmux" .

if [[ ! -d "${SCRIPTS}" ]]; then
  git clone https://github.com/lindhe/scripts.git "${SCRIPTS}"
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
