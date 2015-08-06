# How to btrfs incremental snapshot backups

https://btrfs.wiki.kernel.org/index.php/Incremental_Backup#Doing_it_by_hand.2C_step_by_step

## Inital Bootstrapping
* `sudo btrfs subvolume snapshot -r /home /snap/home/initial`
* `sudo btrfs subvolume snapshot -r / /snap/root/initial`
* `sync`
* `sudo su -c "btrfs send /snap/home/initial | btrfs receive /backup"`
* `sudo su -c "btrfs send /snap/root/initial | btrfs receive /backup"`

## Incremental Operation
* `sudo su -c "btrfs subvolume snapshot -r /home /snap/home/2015-07-08_21:35:34"`
* `sync`
* `sudo su -c "btrfs send -p /snap/home/initial /snap/home/2015-07-08_21:38:32 | btrfs receive /backup/home"`
* `sudo su -c "btrfs send -p /snap/root/initial /snap/root/2015-07-08_21:38:54 | btrfs receive /backup/root"`


# Debian dist-upgrade
* `apt-get update`
* `apt-get upgrade`
* `apt-get dist-upgrade`
* `sed -i 's/wheezy/jessie/g' /etc/apt/sources.list`
* `apt-get update`
* `apt-get upgrade`
* `apt-get dist-upgrade`
* `reboot`
