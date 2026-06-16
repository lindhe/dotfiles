# Backups

Here are upstream docs:

- <https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html>

Populate `/etc/restic/env`:

```shell
cat << EOF | sudo tee /etc/restic/env
B2_ACCOUNT_ID='<replace-me>'
B2_ACCOUNT_KEY='<replace-me>'
RESTIC_CACHE_DIR=/storage/cache/restic
RESTIC_PASSWORD_FILE=/etc/restic/restic.server.key
RESTIC_REPOSITORY="b2:${BUCKET_NAME:?}:/"
EOF
```

Create an exclude file, for example like this:

```shell
cat << EOF | sudo tee /etc/restic/exclude-file.txt
Trash
EOF
```

Configure the [restic-backup.sh](restic-backup.sh) script and [systemd/](systemd/) files appropriately.

> [!NOTE]
> To use `env -f` in Ubtuntu 24.04, one must install `rust-coreutils` and use path `/usr/lib/cargo/bin/coreutils/env`.
> On Ubuntu 26.04, this can simply be replaced by `env`.

Initialize and create a backup:

```shell
sudo /usr/lib/cargo/bin/coreutils/env -f /etc/restic/env restic init
sudo /usr/lib/cargo/bin/coreutils/env -f /etc/restic/env ./restic-backup.sh
```

Configure recurring backups using systemd:

```shell
sudo install -m 0750 restic-backup.sh /usr/local/sbin/restic-backup.sh
sudo install -m 0644 -t /etc/systemd/system ./systemd/*
sudo systemctl daemon-reload
sudo systemctl enable --now restic-backup.timer
```
