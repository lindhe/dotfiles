# shellcheck disable=SC2148,SC1090,SC2034
# vim: foldmethod=marker

###############################     exports     ###############################
# {{{

# set PATH so it includes ~/bin
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes ~/.local/bin
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

path+=/opt/nvim-linux64/bin
# By exporting PATH via `typeset -TUx PATH path`, there are no duplicates.
# With this in place, PATH can safely be updated by running `path+=/tmp/foo`
#
# Stolen from here:
# https://stackoverflow.com/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh/18077919#comment72796046_18077919
typeset -TUx PATH path

# Source Cargo's env
source "$HOME/.cargo/env"

# }}}

##############################     Completion     ##############################
# {{{

# Bash completion
autoload -U +X bashcompinit && bashcompinit

# }}}

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

###############################     Bindings     ###############################
# {{{

bindkey -e # Emacs keybind mode. Without this, setting EDITOR to Vim will change the defaults

# Remove annoying backward-kill-word
# https://stackoverflow.com/questions/39428667/how-to-remove-a-keybinding
bindkey -r '^[^H'

bindkey '^[M' '_toggle_md_mode'

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/ '$'\n'
# autoload -Uz select-word-style
# select-word-style normal
# zstyle ':zle:*' word-style unspecified

autoload edit-command-line
zle -N edit-command-line
bindkey '^X^e' edit-command-line

# }}}

###############################     History     ###############################
# {{{
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt APPEND_HISOTRY
# }}}

###############################     VS Code     ###############################
if [[ "${TERM_PROGRAM}" == "vscode" ]]; then
  export EDITOR='code --wait'
fi

################################     Prompt     ################################
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
