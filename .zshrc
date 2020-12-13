## Überimportant:
# Fixing <C-s> issue (see http://unix.stackexchange.com/a/72092/33928)
stty -ixon

###############################     History     ###############################
HISTFILE=$HOME/.zsh_history
HISTSIZE=SAVEHIST=99999
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD
# Allow bash-like comments inline
setopt interactivecomments

##############################     Completion     ##############################
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select

autoload -U compinit
compinit
zstyle ':completion:*:*:vim:*' file-patterns '*.tex:*.bib:source-files' '*:all-files'

source ~/.config/zsh/autocomplete/helm.zsh
source ~/.config/zsh/autocomplete/kubectl.zsh
source ~/.config/zsh/autocomplete/istioctl.zsh
source ~/.config/zsh/autocomplete/minikube.zsh
source ~/.jfrog/jfrog_zsh_completion
# source ~/.config/zsh/autocomplete/jupyter.zsh

# Exports
export PATH=$PATH
export PATH="${PATH}:${KREW_ROOT:-$HOME/.krew}/bin"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

# Enable colors
autoload -U colors
colors

# Cooler prompt
autoload -U promptinit
promptinit

# Configure prompt
PROMPT="%{$fg_bold[white]%}%n%{$fg[magenta]%}@%{$fg_no_bold[cyan]%}%m %{$fg_no_bold[yellow]%}%~ %{$reset_color%}>%"
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# New terminals adopt current directory
set VTE_FILE = /etc/profile.d/vte.sh
if [[ -a $VTE_FILE ]]; then
  source $VTE_FILE
fi

# Keybindings
bindkey "^[[3~" delete-char

##############################     Functions     ##############################
timestamp() {
    date +'%F_%T'
}

datestamp() {
    date +'%F'
}

m2p() {
    pandoc $1 -s -f gfm -o $1.pdf &&\
    rename md.pdf pdf ./$1.pdf
}

checksum() {
    echo "$1 $2" > /tmp/hash.txt &&\
        printf 'md5:\n'; md5sum -c /tmp/hash.txt;\
        printf '\n';\
        printf 'sha256:\n'; sha256sum -c /tmp/hash.txt
}

title() {
    echo -ne "\033]0;${1}\007"
}

# Search on both snap and apt
apps() {
    snap search $1
    apt search $1
}

# ddiso() {
#     size=$(stat -c%s $1)
#     dd if=$1 &> /dev/null | pv -petra -s $size | dd of=$2 bs=4k
# }

# base64 -d
bd() {
    echo "$1" | base64 -d ; echo
}

stderr() {
    python -c "import sys; print('$1', file=sys.stderr)"
}

## Aliases

# edit rc files
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias zathurarc="vim ~/.config/zathura/zathurarc"

# Propagate aliases to sudo
alias s="sudo "
alias sudo="sudo "
alias sudoedit="sudoedit "

# General
alias ..="cd .."
alias bcl="bluetoothctl"
alias df="df -H"
alias du="du -h"
alias l="ls -FHhlv --color=always --group-directories-first"
alias ll="ls -aFhlv --color=always"
alias ls="ls -Hhv --color=always"
alias lsl="ls -Ahl --color=always"
alias mkdir="mkdir -p"
alias open="xdg-open"
alias pac="pacman"
alias pik="pikaur"
alias qq="exit"
alias rml="rm *.aux; rm *.out; rm *.toc; rm *.log; rm *.lof; rm *.lot; rm *.tdo; rm *.dvi; rm *.bbl; rm *.blg; rm *bcf; rm *.run.xml; rm *-blx.bib; rm *.apc"
alias se="sudoedit"
alias so="source"
alias tat="tmux attach -t"
alias tls="tmux list-sessions"
alias tree="tree -C"
alias watch="watch --color"
alias yao="yaourt"
alias gitdiff="git diff --no-index --"
alias v="vim -p"

# Docking
alias keyboard="xset r rate 330 75; setxkbmap se-A5; setxkbmap -option caps:swapescape"
alias monitors="~/scripts/monman.py -a && echo 'Monitors on'"
alias unmonitors="xrandr --output eDP-1 --auto --primary --output HDMI-1 --off --output DP-1 --off --output DP-2 --off; echo 'off'"


# Git
alias g="git"
alias ga="git add -p"
alias gap="git add -p"
alias gam="git commit -am"
alias gc="git commit"
alias gcm="git commit -m"
alias gi="git"
alias gif="git diff"
alias gil="git l"
alias gill="git lob"
alias gip="git pl"
alias gis="git status"
alias gs="git status"
alias gg="git grep"

alias pac="pacman"
alias qq="exit"
alias rmb="rm *.bbl; rm *.blg; rm *.bcf; rm *.run.xml; rm *-blx.bib"
alias rmt="rm *.aux; rm *.out; rm *.toc; rm *.log; rm *.tdo; rm *.fdb_latexmk; rm *dvi; rm *.fls"
alias sudovim="sudoedit "
alias tat="tmux attach -t"
alias tls="tmux list-sessions"
alias tree="tree -C"
alias watch="watch --color"

# Dev
export GOPATH=/home/andreas/go
alias d="docker"
alias dc="docker-compose"
alias h="helm"
alias hf="helmfile"
alias mk="microk8s.kubectl"
alias pp="pipenv"
alias ipy="ipython3"
alias wkga="watch kubectl get all"
alias t="terraform"
alias mp="multipass"

# Kubernetes
alias k="kubectl"
alias kc="kubectl config"
alias kns="kubectl config set-context --current --namespace"
alias ktop='kubectl top'
alias kk="kubectl -n andreas"
alias hh="helm -n andreas"
alias m="minikube"
alias i="istioctl"
alias tf="terraform"
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kd='kubectl describe'
alias kg='kubectl get'

# non-important
alias cal="cal -m"
alias starwars="telnet towel.blinkenlights.nl"
alias gnu="gnuplot"
alias vimcognito="vim -i NONE -u NONE -U NONE --cmd 'set noswapfile' --cmd 'set nobackup'"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/andreas/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/andreas/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/andreas/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/andreas/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

