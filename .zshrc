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
ZSH_WSL=~/.zsh_wsl
if [[ -f ${ZSH_WSL} ]]; then
    source ${ZSH_WSL}
else
    echo "* ${ZSH_WSL} is missing" >> ${TODOFILE}
fi
# }}}

##############################     Functions     ##############################
# {{{
ZSH_FUNCTIONS=~/.zsh_functions
if [[ -f ${ZSH_FUNCTIONS} ]]; then
    source ${ZSH_FUNCTIONS}
else
    echo "* ${ZSH_FUNCTIONS} is missing" >> ${TODOFILE}
fi
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
