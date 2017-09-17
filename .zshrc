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
zstyle ':completion:*:*:vim:*' file-patterns '*.tex:*.bib:source-files' '*:all-files'

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

m2p() {
    pandoc $1 -s -o $1.pdf &&\
    rename md.pdf pdf ./$1.pdf
}

checksum() {
    echo "$1 $2" > /tmp/hash.txt &&\
        printf 'md5:\n'; md5sum -c /tmp/hash.txt;\
        printf '\n';\
        printf 'sha256:\n'; sha256sum -c /tmp/hash.txt
}


#ddiso() {
    #size=$(stat -c%s $1)
    #dd if=$1 &> /dev/null | pv -petra -s $size | dd of=$2 bs=4k
#}

## Aliases

# edit rc files
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

# Propagate aliases to sudo
alias sudo="sudo "
alias sudoedit="sudoedit "

# General
alias ..="cd .."
alias bcl="bluetoothctl"
alias cdh="cd ~/"
alias df="df -H"
alias du="du -h"
alias l="ls -FHhlv --color=always"
alias ll="ls -aFhlv --color=always"
alias ls="ls -Hhv --color=always"
alias lsl="ls -Ahl --color=always"
alias mkdir="mkdir -p"
alias open="xdg-open"
alias pac="pacaur"
alias qq="exit"
alias rml="rm *.aux; rm *.out; rm *.toc; rm *.log; rm *.lof; rm *.lot; rm *.tdo; rm *.dvi; rm *.bbl; rm *.blg; rm *bcf; rm *.run.xml; l"
alias se="sudoedit"
alias so="source"
alias tat="tmux attach -t"
alias tls="tmux list-sessions"
alias tree="tree -C"
alias vimrc="vim ~/.vimrc"
alias watch="watch --color"
alias yao="yaourt"
alias zshrc="vim ~/.zshrc"

# Docking
alias keyboard="xset r rate 330 75; setxkbmap se-A5; setxkbmap -option caps:swapescape"
alias monitors="~/scripts/monman.py -a && echo 'Monitors on'"
alias unmonitors="xrandr --output eDP-1 --auto --primary --output HDMI-1 --off --output DP-1 --off --output DP-2 --off; echo 'off'"


# Git
alias g="git"
alias gi="git"
alias gif="git diff"
alias gil="git log --oneline --decorate"
alias gip="git pl"
alias gis="git status"
alias gs="git status"
alias pac="pacaur"
alias qq="exit"
alias rmb="rm *.bbl; rm *.blg; rm *.bcf; rm *.run.xml; rm *-blx.bib"
alias rmt="rm *.aux; rm *.out; rm *.toc; rm *.log; rm *.tdo; rm *.fdb_latexmk; rm *dvi; rm *.fls"
alias rml="rmb;rmt"
alias so="source"
alias sudovim="sudoedit "
alias tat="tmux attach -t"
alias tls="tmux list-sessions"
alias tree="tree -C"
alias watch="watch --color"

# non-important
alias cal="cal -m"
alias starwars="telnet towel.blinkenlights.nl"
alias gnu="gnuplot"

