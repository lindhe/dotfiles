#!/usr/bin/env bash

set -euo pipefail

stderr() {
    echo "${@}" 1>&2
}

fail() {
    stderr "${1}"
    stderr ""
    stderr "Exiting …"
    exit "${2:-1}"
}

readonly DOTFILES="${HOME}/dotfiles"

while [[ ${ready:-x} != 'y' ]]; do
    echo "Have you cloned dotfiles into ${DOTFILES}? (y/n)"
    read -rn 1 ready
    echo -e "\n"
done;

cd "${DOTFILES}"

echo "Do you want a minimal setup? [Y/n]"
read -rn 1 yn
if [[ "${yn}" == [Nn]* ]]; then
    readonly FULL_SETUP=y
else
    readonly FULL_SETUP=n
fi
echo -e "\n"

./bootstrap.sh

sudo ln -fs "$(which safe-rm)" /usr/local/bin/rm

if [[ "${FULL_SETUP}" == y ]]; then

    pushd ~/.config

    ln -fs "${DOTFILES}/.config/compton.conf" .
    ln -fs "${DOTFILES}/.config/dunst/" .
    ln -fs "${DOTFILES}/.config/i3" .
    ln -fs "${DOTFILES}/.config/i3blocks/" .
    ln -fs "${DOTFILES}/.config/monitors/" .
    ln -fs "${DOTFILES}/.config/safe-rm" .
    ln -fs "${DOTFILES}/.config/sway" .

    popd

    echo "Installing custom keyboard layouts"
    sudo cp "${DOTFILES}/usr/share/X11/xkb/symbols"/* -t /usr/share/X11/xkb/symbols

    # Set shell
    sudo chsh -s /usr/bin/zsh "${USER}"

    # Configure locale
    sudo locale-gen sv_SE.UTF-8
    ( sudo tee -a /etc/default/locale ) < ~/dotfiles/locale/sv_SE

    # Set NeoVim as default editor
    sudo update-alternatives --install /usr/bin/vim vim "$(which nvim)" 100
    sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 100

    # Add me to the `docker` group
    sudo usermod -aG docker "${USER}"


    echo "Creating ${APT_DIR}"
    mkdir -p "${APT_DIR}"
    sudo chown -R "_apt:${USER}" "${APT_DIR}"

fi
