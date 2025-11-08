# shellcheck disable=SC2148,SC1090,SC2034
# vim: foldmethod=marker

###############################     exports     ###############################
# {{{

path+=/opt/nvim-linux64/bin
# By exporting PATH via `typeset -TUx PATH path`, there are no duplicates.
# With this in place, PATH can safely be updated by running `path+=/tmp/foo`
#
# Stolen from here:
# https://stackoverflow.com/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh/18077919#comment72796046_18077919
typeset -TUx PATH path

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

# Remove annoying backward-kill-word
# https://stackoverflow.com/questions/39428667/how-to-remove-a-keybinding
bindkey -r '^[^H'

bindkey '^[M' '_toggle_md_mode'

# }}}

##############################     Completion     ##############################
# {{{

# Bash completion
autoload -U +X bashcompinit && bashcompinit

# }}}

###############################     VS Code     ###############################
if [[ "${TERM_PROGRAM}" == "vscode" ]]; then
  export EDITOR='code --wait'
fi

################################     Prompt     ################################
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

#################################     last     #################################
# {{{
# This is the last file to be sourced by .zshrc.
# Should fail silent, so I can use it for unsetting aliases for particular
# environments and don't have to commit that file.
ZSH_LAST=~/.zsh_last
if [[ -f ${ZSH_LAST} ]]; then
    source ${ZSH_LAST}
fi
# }}}
