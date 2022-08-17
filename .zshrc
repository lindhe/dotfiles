# vim: foldmethod=marker
## Überimportant:
# Fixing <C-s> issue (see http://unix.stackexchange.com/a/72092/33928)
stty -ixon

###########################     Profiling Start     ###########################
# Enable this (and zprof at bottom) for profiling.
# https://stevenvanbael.com/profiling-zsh-startup
# zmodload zsh/zprof

############################     TODO-file init     ############################
# {{{
TODOFILE=~/TODO.zsh.md
# Clear the TODO-file
rm --force ${TODOFILE}
# }}}

###############################     History     ###############################
# {{{
HISTFILE=${ZDOTDIR:-~}/.zsh_history
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
# }}}

#################################     Misc     #################################
# {{{
# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD
# Allow bash-like comments inline
setopt interactivecomments

# Edit commmands
# https://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Set NO_UNSET option
set -u

# }}}

##############################     Completion     ##############################
# {{{
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select

autoload -U compinit
compinit
zstyle ':completion:*:*:vim:*' file-patterns '*.tex:*.bib:source-files' '*:all-files'

# Native ZSH completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
else
    echo "* kubectl is missing" >> ${TODOFILE}
fi
if command -v helm &> /dev/null; then
    source <(helm completion zsh)
else
    echo "* helm is missing" >> ${TODOFILE}
fi

# Bash completion
autoload -U +X bashcompinit && bashcompinit
AZCLI_COMPLETION="/etc/bash_completion.d/azure-cli"
if [[ -f ${AZCLI_COMPLETION} ]]; then
    source ${AZCLI_COMPLETION}
else
    echo "* ${AZCLI_COMPLETION:?} is missing" >> ${TODOFILE}
fi
complete -o nospace -C /usr/bin/terraform terraform

# }}}

##########################     Prompt and colors     ##########################
# {{{
# Enable colors
autoload -U colors
colors

# Cooler prompt
autoload -U promptinit
promptinit

# Configure prompt
PROMPT="%{$fg_bold[white]%}%n%{$fg[magenta]%}@%{$fg_no_bold[cyan]%}%m %{$fg_no_bold[yellow]%}%~ %{$reset_color%}>%"
source ${ZDOTDIR:-~}/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# }}}

################################     Fixes     ################################
# {{{
# Keybindings
bindkey "^[[3~" delete-char
# }}}

#################################     WSL2     #################################
# {{{
if [[ "$(uname -r)" =~ .*microsoft.* ]]; then

    if command -v wslpath &> /dev/null; then
        # Set PROMPT_COMMAND to let us duplicate with path
        # https://docs.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory
        PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
        precmd() { eval "$PROMPT_COMMAND" }
    fi

    if command -v docker &> /dev/null; then
        # Check if docker service exists
        if service --status-all |& grep -qE ' docker$'; then
            # Start the docker service unless it's already running
            if ! service docker status > /dev/null ; then
                echo "Service docker not running!"
                echo "service docker start ..."
                sudo service docker start
            fi
        else
            echo "* service docker is missing" >> ${TODOFILE}
        fi
    fi

fi

# }}}

##############################     Functions     ##############################
# {{{

# Search on both snap and apt
apps() {
    snap search $1
    apt search $1
}

# base64 -d
bd() {
    echo "$1" | base64 -d ; echo
}

checksum() {
    echo "$1 $2" > /tmp/hash.txt &&\
        printf 'md5:\n'; md5sum -c /tmp/hash.txt;\
        printf '\n';\
        printf 'sha256:\n'; sha256sum -c /tmp/hash.txt
}

# Copy the contents of a file to the clipboard and put its name in primary
copy() {
    # If WSL
    if [[ "$(uname -r)" =~ .*microsoft.* ]]; then
        cat ${1:?} | /mnt/c/Windows/System32/clip.exe
    else
        cat ${1:?} | xclip -selection clipboard
        echo -n ${1:?} | xclip -selection primary
    fi
}

datestamp() {
    date +'%F'
}

# setup kubectl environment
kinit() {
    if $(command -v helm &> /dev/null); then
        source <(helm completion zsh)
    fi
    if $(command -v kubectl &> /dev/null); then
        source <(kubectl completion zsh)
    fi
    if $(command -v minikube &> /dev/null); then
        source <(minikube completion zsh)
    fi
}

m2p() {
    pandoc $1 -s -f gfm -o $1.pdf &&\
    rename md.pdf pdf ./$1.pdf
}

stderr() {
    python -c "import sys; print('$1', file=sys.stderr)"
}

timestamp() {
    date +'%F_%T'
}

title() {
    echo -ne "\033]0;${1}\007"
}

mcd() {
    mkdir -p ${1:?Missing argument to mcd.}
    cd ${1}
}

# }}}

###############################     Aliases     ###############################
# {{{
# edit rc files
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias vimrc="vim ~/.vimrc"
alias zathurarc="nvim ~/.config/zathura/zathurarc"
alias zshrc="nvim ~/.zshrc"

# Propagate aliases and environment to sudo
alias sudo="sudo -E "
alias sudoedit="sudoedit "

# General
alias .....="cd ../../../.."
alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."
alias bcl="bluetoothctl"
alias df="df -H"
alias du="du -h"
alias dusch="du -sch .[^.]* * | sort -h"
alias gitdiff="git diff --no-index --"
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
alias svim="sudoedit"
alias tat="tmux attach -t"
alias tls="tmux list-sessions"
alias tree="tree -C"
alias watch="watch --color"
alias yao="yaourt"

# Docking
alias keyboard="xset r rate 330 75; setxkbmap se-A5; setxkbmap -option caps:swapescape"
alias monitors="~/scripts/monman.py -a && echo 'Monitors on'"
alias unmonitors="xrandr --output eDP-1 --auto --primary --output HDMI-1 --off --output DP-1 --off --output DP-2 --off; echo 'off'"


# Git
alias g="git"
alias ga="git add -p"
alias gam="git commit -am"
alias gap="git add -p"
alias gc="git commit"
alias gcm="git commit -m"
alias gg="git grep -i"
alias gi="git"
alias gif="git diff"
alias gil="git l"
alias gill="git lob"
alias gip="git pl"
alias gis="git status"
alias gs="git status"

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
alias d="docker"
alias dc="docker-compose"
alias h="helm"
alias hf="helmfile"
alias hs="helm secrets"
alias ipy="ipython3"
alias mk="microk8s.kubectl"
alias mp="multipass"
alias pp="pipenv"
alias t="terraform"
alias wkga="watch kubectl get all"
alias bbb="(base64 -d ; echo)"
alias tf="terraform"

# Kubernetes
alias k="kubectl"
alias kaf='kubectl apply -f'
alias kc="kubectl config"
alias kcc='kubectl create --dry-run=client -o yaml'
alias kcd='kubectl create --dry-run=client -o yaml'
alias kdesc='kubectl describe'
alias kg='kubectl get'
alias kget='kubectl get'
alias ktop='kubectl top'

# non-important
alias cal="cal -m"
alias gnu="gnuplot"
alias jqless="jq -C '' | less -Ri"
alias starwars="telnet towel.blinkenlights.nl"
alias vimcognito="vim -i NONE -u NONE -U NONE --cmd 'set noswapfile' --cmd 'set nobackup'"
alias yqless="yq -C eval | less -Ri"

# }}}

############################     Profiling End     ############################
# zprof
