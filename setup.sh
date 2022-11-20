#!/usr/bin/env bash

set -euo pipefail

fail() {
    echo "FAILURE: ${1}" >&2
    exit "${2:-1}"
}

while [[ ${ready:-x} != 'y' ]]; do
    echo "Have you cloned into ~/git/lindhe/dotfiles/? (y/n)"
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

    ln -fs ../git/lindhe/dotfiles/.config/compton.conf .
    ln -fs ../git/lindhe/dotfiles/.config/dunst/ .
    ln -fs ../git/lindhe/dotfiles/.config/i3 .
    ln -fs ../git/lindhe/dotfiles/.config/i3blocks/ .
    ln -fs ../git/lindhe/dotfiles/.config/monitors/ .
    ln -fs ../git/lindhe/dotfiles/.config/sway .
    ln -fs ../git/lindhe/dotfiles/.config/zathura/ .

    popd

    echo "Installing custom keyboard layouts"
    sudo cp ~/git/lindhe/dotfiles/usr/share/X11/xkb/symbols/* -t /usr/share/X11/xkb/symbols

fi
