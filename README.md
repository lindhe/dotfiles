# dotfiles

These are my dotfiles. Not meant to be shared, but feel free to take a look if you want to.

## Subtrees

I'm trying out `git subtree` to bring in dependencies. I know of no way to list
them easily, so I'll try to keep a list of them here:

* `.config/i3blocks/contrib` https://github.com/vivien/i3blocks-contrib
* `.config/zsh/plugins/zsh-syntax-highlighting` https://github.com/zsh-users/zsh-syntax-highlighting.git

## Usage

```shell
git clone https://github.com/lindhe/dotfiles.git ~/git/lindhe/dotfiles
git clone https://github.com/lindhe/scripts.git ~/git/lindhe/scripts
~/git/lindhe/dotfiles/setup.sh
```

### Install dependencies

```shell
sudo apt install \
    neovim tree zsh \
    build-essential
```

#### GUI extras

```shell
sudo apt install \
    dunst i3 j4-dmenu-desktop playerctl rofi
```

#### Server extras

```shell
sudo apt install \
    zfsutils-linux
sudo snap install \
    nextcloud
```

- [ ] <https://github.com/zfsonlinux/zfs-auto-snapshot>

## Post-install checklist

### Usability

- [ ] Set shell: `sudo chsh -s /usr/bin/zsh andreas`
- [ ] Configure locale:

    ```shell
    sudo locale-gen sv_SE.UTF-8
    cat ~/git/lindhe/dotfiles/locale/sv_SE | sudo tee -a /etc/default/locale
    ```

### Hardening

- [ ] SSH hardening.
- [ ] Setup SSH keys: `ssh-keygen -b 4096 -C "${USER:?}@$(hostname -f)"`
- [ ] Ubuntu Live Patch: https://ubuntu.com/advantage

