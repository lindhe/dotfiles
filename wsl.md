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
sudo unlink /etc/resolv.conf

sudo tee -a /etc/wsl.conf <<EOF
[network]
generateResolvConf = false
EOF

sudo tee /etc/resolv.conf <<EOF
nameserver 9.9.9.9
nameserver 149.112.112.112
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

sudo chattr +i /etc/resolv.conf #  https://github.com/microsoft/WSL/issues/6977
```

## Remove Windows Path

```console
sudo tee -a /etc/wsl.conf <<EOF
[interop]
appendWindowsPath = false
EOF
```

## Configure Git Credential Helper

```console
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"
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
