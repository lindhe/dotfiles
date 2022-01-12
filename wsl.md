# WLS2

Things to do when I'm forced to use Windows...

## Install WSL2

<https://docs.microsoft.com/en-us/windows/wsl/install>

## Configure home directory in Windows Terminal

```
\\wsl$\Ubuntu\home\andreas
```

## Fix DNS

```console
echo -e "[network]\ngenerateResolvConf = false" | sudo tee /etc/wsl.conf
sudo unlink /etc/resolv.conf
echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1\nnameserver 8.8.8.8\nnameserver 8.8.4.4" | sudo tee /etc/resolv.conf
```
