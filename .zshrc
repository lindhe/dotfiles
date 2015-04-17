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

## Functions
timestamp() {
    date +'%F_%T'
}


## Aliases
# Propagate aliases to sudo
alias sudo="sudo "

# General
alias s="sudo"
alias ..="cd .."
alias ls="ls --color=auto"
alias lsl="ls -hl --color=auto"
alias ll="ls -ahl --color=auto"
alias clr="clear"
alias tat="tmux attach -t"
alias tls="tmux list-sessions"
alias mkdir="mkdir -p"
alias tree="tree -C"
alias se="sudoedit"
alias so="source"
alias qq="exit"
alias cdh="cd ~/"
alias yao="yaourt"

# Git
alias gpr="git pull --rebase"
alias gca="git commit -a"
alias gpm="git push -u origin master"
alias gs="git status"
alias gl="git log"
alias gad="git add"
alias gb="git branch"
