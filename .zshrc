# vim: foldmethod=marker
## Überimportant:
# Fixing <C-s> issue (see http://unix.stackexchange.com/a/72092/33928)
# tags: ctrl+x
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
if $(command -v k3d &> /dev/null); then
    source <(k3d completion zsh)
else
    echo "* k3d is missing" >> ${TODOFILE}
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

for f in ~/.config/zsh/autocomplete/*; do
  if [[ -f ${f} ]]; then
    source ${f}
  else
    echo "Unable to source '${f}'" 1>&2
  fi
done

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
PROMPT="%{$fg_bold[white]%}%n%{$fg[magenta]%}@%{$fg_no_bold[cyan]%}%m %{$fg_no_bold[yellow]%}%~ %{$reset_color%}$ %"
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

# Copy path to current working directory
cwd() {
    # If WSL
    if [[ "$(uname -r)" =~ .*microsoft.* ]]; then
        pwd | /mnt/c/Windows/System32/clip.exe
    else
        pwd | xclip -selection clipboard
        pwd | xclip -selection primary
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

password() {
  if command -v openssl &> /dev/null; then
    openssl rand -base64 "${1:-32}" | paste -sd '' -
  else
    tr -dc A-Za-z0-9 </dev/urandom | head -c "${1:-32}" ; echo ''
  fi
}

# }}}

###############################     Aliases     ###############################
# {{{
ZSH_ALIASES=~/.zsh_aliases
if [[ -f ${ZSH_ALIASES} ]]; then
    source ${ZSH_ALIASES}
else
    echo "* ${ZSH_ALIASES} is missing" >> ${TODOFILE}
fi
# }}}

############################     Profiling End     ############################
# zprof
