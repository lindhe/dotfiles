#!/usr/bin/env bash
# shellcheck disable=SC1091

###############################     prelude     ###############################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#################################     PATH     #################################
# {{{
# set PATH so it includes ~/bin
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes ~/.local/bin
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Source Cargo's env
if [ -f "$HOME/.cargo/env" ] ; then
  source "$HOME/.cargo/env"
fi

# }}}

###############################     history     ###############################
# {{{
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999
HISTFILESIZE=9999

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Failed history substitution (e.g. `!ls`) gets a second chance:
shopt -s histreedit

# Verify history substitution before running:
shopt -s histverify

# https://askubuntu.com/a/673283
PROMPT_COMMAND='history -a;history -n'
# }}}

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

######################     Source all .shellrc files     ######################
# {{{
SHELLRC_DIR="${HOME}/.shellrc"
if [[ -d "${SHELLRC_DIR}" ]]; then
  for shellrc_file in "${SHELLRC_DIR}"/*; do
    # shellcheck source=/dev/null
    source "${shellrc_file}"
  done
else
  echo "${SHELLRC_DIR} is missing"
fi
# }}}

##############################     Local env     ##############################
# File to source for the user's local environemnt.
# {{{
SHELL_ENV_FILE=~/.shellrc/env
if [[ -f ${SHELL_ENV_FILE} ]]; then
    # shellcheck source=/dev/null
    source "${SHELL_ENV_FILE}"
fi
# }}}
