#!/usr/bin/env bash
# shellcheck disable=SC1091

###############################     prelude     ###############################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

###############################     history     ###############################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999
HISTFILESIZE=9999

# Failed history substitution (e.g. `!ls`) gets a second chance:
shopt -s histreedit

# Verify history substitution before running:
shopt -s histverify

################################     window     ################################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

###########################     quality of life     ###########################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support via dircolors
if command -v dircolors &> /dev/null; then
    # shellcheck disable=SC2015
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

###############################     aliases     ###############################
# {{{
SHELL_ALIASES_FILE=~/.shell_aliases
if [[ -f ${SHELL_ALIASES_FILE} ]]; then
    # shellcheck source=./.shell_aliases
    source "${SHELL_ALIASES_FILE}"
else
    echo "* ${SHELL_ALIASES_FILE} is missing"
fi
# }}}

##############################     Completion     ##############################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

##############################     navigation     ##############################

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Enhance cd
shopt -s autocd

# Let * expand to hidden files also:
shopt -s dotglob

# Expand dir to explicit path (like ZSH)
shopt -s direxpand

################################     Prompt     ################################

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "${TERM}" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+(${debian_chroot})}\u@\h: \w\a\]${PS1}"
    ;;
*)
    ;;
esac

# Enable fancy prompt
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

##############################     Kubernetes     ##############################
# {{{

# Populate KUBECONFIG
if command -v kubectl &> /dev/null; then
  DOTKUBE_DIR="${HOME}/.kube"
  if [ -d "${DOTKUBE_DIR}" ]; then
    export KUBECONFIG="${DOTKUBE_DIR}/config"
    shopt -s globstar
    for config in "${DOTKUBE_DIR}"/**/*.yaml; do
      export KUBECONFIG="${KUBECONFIG}:${config}"
    done
  else
    echo "${DOTKUBE_DIR} is missing"
  fi
fi

# Configure difftool
export KUBECTL_EXTERNAL_DIFF="diff -u --color=always"

# }}}

#################################     Helm     #################################
# {{{
# Configure helm-diff
export HELM_DIFF_OUTPUT_CONTEXT=2
export HELM_DIFF_USE_UPGRADE_DRY_RUN=true
# }}}

# ##############################     Functions     ##############################
# {{{
SHELL_FUNCTIONS_FILE=~/.shell_functions
if [[ -f ${SHELL_FUNCTIONS_FILE} ]]; then
    # shellcheck source=./.shell_functions
    source "${SHELL_FUNCTIONS_FILE}"
else
    echo "* ${SHELL_FUNCTIONS_FILE} is missing"
fi
# }}}

#################################     WSL2     #################################
# {{{
SHELL_WSL_FILE=~/.shell_wsl
if [[ -f ${SHELL_WSL_FILE} ]]; then
    # shellcheck source=./.shell_wsl
    source "${SHELL_WSL_FILE}"
else
    echo "* ${SHELL_WSL_FILE} is missing"
fi
# }}}
