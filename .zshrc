## Überimportant:
# Fixing <C-s> issue (see http://unix.stackexchange.com/a/72092/33928)
stty -ixon

# History
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
#setopt AUTO_CD

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select

autoload -U compinit
compinit

# Exports
export PATH=$PATH

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

# Keybindings
bindkey "^[[3~" delete-char

## Functions
timestamp() {
    date +'%F_%T'
}

datestamp() {
    date +'%F'
}

mcd() {
    mkdir -p "$1"
    cd "$1"
}

m2p() {
    pandoc $1 -s -o $1.pdf
    rename md.pdf pdf ./$1.pdf
}

#ddiso() {
    #size=$(stat -c%s $1)
    #dd if=$1 &> /dev/null | pv -petra -s $size | dd of=$2 bs=4k
#}

## Aliases
# Propagate aliases to sudo
alias sudo="sudo "
alias sudoedit="sudoedit "

# General
alias sudovim="sudoedit "
alias ..="cd .."
alias ls="ls -h --color=auto"
alias ll="ls -hl --color=auto"
alias lsl="ls -ahl --color=auto"
alias tat="tmux attach -t"
alias tls="tmux list-sessions"
alias mkdir="mkdir -p"
alias tree="tree -C"
alias se="sudoedit"
alias so="source"
alias qq="exit"
alias cdh="cd ~/"
alias yao="yaourt"
alias pac="pacaur"
alias open="xdg-open"
alias df="df -H"
alias du="du -h"
alias bc="bc -l"
alias rmlatex="rm *.aux; rm *.out; rm *.toc; rm *.log"
alias rml="rm *.aux; rm *.out; rm *.toc; rm *.log; rm *.lof; rm *.lot; rm *.tdo; rm *.dvi"
alias rmb="rm *.bbl; rm *.blg; rm *bcf; rm *.run.xml"
alias watch="watch --color"
alias bcl="bluetoothctl"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

# Git
alias gi="git"
alias gis="git status"
alias gs="git status"
alias gif="git diff"
alias gip="git pull"
alias gil="git log --oneline --decorate"

# non-important
alias cal="cal -m"
alias starwars="telnet towel.blinkenlights.nl"
alias gnu="gnuplot"

