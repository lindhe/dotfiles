# dotfiles

These are my dotfiles. Not meant to be shared, but feel free to take a look if you want to.

## Subtrees

I'm trying out `git subtree` to bring in dependencies. I know of no way to list
them easily, so I'll try to keep a list of them here:

* `.config/i3blocks/contrib` https://github.com/vivien/i3blocks-contrib

## Usage

```shell
git clone https://github.com/lindhe/dotfiles.git ~/dotfiles
git clone https://github.com/lindhe/scripts.git ~/git/lindhe/scripts
~/dotfiles/setup.sh
```

### Install dependencies

```shell
sudo add-apt-repository ppa:git-core/ppa
```

```shell
sudo apt install \
    curl \
    tree zsh \
    build-essential \
    curl \
    git git-lfs \
    tmux jq unzip shellcheck colordiff
```

```shell
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
export PATH="$PATH:/opt/nvim-linux64/bin"
```

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
    restic \
    ipmitool
sudo snap install \
    nextcloud
```

```
export DOTFILES=~/dotfiles

pushd ~
ln -fs "${DOTFILES:?}/.zsh_server" .
popd
```

```
sudo ipmitool sensor thresh FAN2 lower 0 100 200
sudo ipmitool sensor thresh FAN3 lower 0 100 200
```

- [ ] <https://github.com/zfsonlinux/zfs-auto-snapshot>
- [ ] <https://www.informaticar.net/supermicro-motherboard-loud-fans/>
- [ ] <https://askubuntu.com/a/1110474/80226>

## Post-install checklist

- [ ] Add me to the `docker` group: `usermod -aG docker ${USER}`
- [ ] SSH hardening.
- [ ] Setup SSH keys: `ssh-keygen -t ed25519 -C "${USER:?}@$(hostname -f)"`
- [ ] Ubuntu Live Patch: https://ubuntu.com/advantage
- [ ] Configure a [Docker Credential Helper](https://github.com/docker/docker-credential-helpers/) in `~/.docker/config.json`.
