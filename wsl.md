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

## Install Docker

```console
sudo apt install --no-install-recommends apt-transport-https ca-certificates curl gnupg2
source /etc/os-release
curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
```

### Start Docker without password

```console
sudo visudo
```

and add the following:

```
# Allow members of group sudo to start docker
%sudo   ALL=(ALL) NOPASSWD: /usr/sbin/service docker start
```

## Remove Windows interoperatbility

```console
$ cat <<EOF | sudo tee /etc/wsl.conf
[interop]
enabled=false
appendWindowsPath=false
EOF
```
