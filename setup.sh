#!/usr/bin/env bash

set -euo pipefail

fail() {
    echo "FAILURE: ${1}" >&2
    exit "${2:-1}"
}

readonly DOTFILES="${HOME}/git/lindhe/dotfiles"

while [[ ${ready:-x} != 'y' ]]; do
    echo "Have you cloned dotfiles into ${DOTFILES}? (y/n)"
    read -rn 1 ready
    echo -e "\n"
done;

echo "Do you want a minimal setup? [Y/n]"
read -rn 1 yn
if [[ "${yn}" == [Nn]* ]]; then
    readonly FULL_SETUP=y
else
    readonly FULL_SETUP=n
fi
echo -e "\n"

./bootstrap.sh

if [[ "${FULL_SETUP}" == y ]]; then

    pushd ~/.config

    ln -fs "${DOTFILES}/.config/compton.conf" .
    ln -fs "${DOTFILES}/.config/dunst/" .
    ln -fs "${DOTFILES}/.config/i3" .
    ln -fs "${DOTFILES}/.config/i3blocks/" .
    ln -fs "${DOTFILES}/.config/monitors/" .
    ln -fs "${DOTFILES}/.config/sway" .
    ln -fs "${DOTFILES}/.config/zathura/" .

    popd

    echo "Installing custom keyboard layouts"
    sudo cp "${DOTFILES}/usr/share/X11/xkb/symbols"/* -t /usr/share/X11/xkb/symbols

fi
