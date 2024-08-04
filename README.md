# dotfiles

These are my dotfiles. Not meant to be shared, but feel free to take a look if you want to.

## Subtrees

I'm trying out `git subtree` to bring in dependencies. I know of no way to list
them easily, so I'll try to keep a list of them here:

* `.config/i3blocks/contrib` https://github.com/vivien/i3blocks-contrib

## Usage

```shell
git clone https://github.com/lindhe/dotfiles.git ~/git/lindhe/dotfiles
git clone https://github.com/lindhe/scripts.git ~/git/lindhe/scripts
~/git/lindhe/dotfiles/setup.sh
```

### Install dependencies

```shell
sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:neovim-ppa/stable
```

```shell
sudo apt install \
    curl \
    neovim tree zsh \
    build-essential \
    curl \
    git git-lfs \
    tmux jq unzip shellcheck colordiff
```

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
```

#### Laptop extras

```shell
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install \
    dunst i3 j4-dmenu-desktop playerctl rofi gnome-screenshot \
    scdaemon pavucontrol keepassxc
```

#### Server extras

```shell
sudo apt install \
    zfsutils-linux zfs-auto-snapshot \
    mailutils msmtp-mta s-nail \
    nfs-kernel-server \
    smartmontools \
    restic
sudo snap install \
    nextcloud
```

```shell
sudo chsh -s /usr/bin/tmux ${USER}`
```

- [ ] <https://github.com/zfsonlinux/zfs-auto-snapshot>
- [ ] <https://www.informaticar.net/supermicro-motherboard-loud-fans/>
- [ ] <https://askubuntu.com/a/1110474/80226>

## Post-install checklist

### asdf

Install all asdf plugins:

```
asdf install
```

### Usability

- [ ] Set shell: `sudo chsh -s /usr/bin/zsh ${USER}`
- [ ] Configure locale:

    ```shell
    sudo locale-gen sv_SE.UTF-8
    cat ~/git/lindhe/dotfiles/locale/sv_SE | sudo tee -a /etc/default/locale
    ```

- [ ] Set NeoVim as default editor:

    ```shell
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor
    ```

- [ ] Add me to the `docker` group: `usermod -aG docker ${USER}`

### Hardening

- [ ] SSH hardening.
- [ ] Setup SSH keys: `ssh-keygen -t ed25519 -C "${USER:?}@$(hostname -f)"`
- [ ] Ubuntu Live Patch: https://ubuntu.com/advantage
- [ ] Configure a [Docker Credential Helper](https://github.com/docker/docker-credential-helpers/) in `~/.docker/config.json`.

