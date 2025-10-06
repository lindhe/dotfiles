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

# Create completions directory
USER_COMPLETIONS_DIR="${HOME}/.config/zsh/completions"
mkdir -p "${USER_COMPLETIONS_DIR:?}"

# x completion zsh
autocompletions=(
  "${X_COMPLETION_ZSH[@]}"
)
for cmd in "${autocompletions[@]}"; do
  if [[ -n "${cmd}" ]]; then
    if command -v "${cmd}" &> /dev/null; then
      ${cmd} completion zsh > "${USER_COMPLETIONS_DIR}/${cmd}.zsh"
    else
      echo "* ${cmd:?} is missing"
    fi
  fi
done

# x completion -s zsh
autocompletions=(
  gh
)
for cmd in "${autocompletions[@]}"; do
  if [[ -n "${cmd}" ]]; then
    if command -v "${cmd}" &> /dev/null; then
      ${cmd} completion -s zsh > "${USER_COMPLETIONS_DIR}/${cmd}.zsh"
    else
      echo "* ${cmd:?} is missing"
    fi
  fi
done

# x shell-completion zsh
autocompletions=(
  yq
)
for cmd in "${autocompletions[@]}"; do
  if [[ -n "${cmd}" ]]; then
    if command -v "${cmd}" &> /dev/null; then
      ${cmd} shell-completion zsh > "${USER_COMPLETIONS_DIR}/${cmd}.zsh"
    else
      echo "* ${cmd:?} is missing"
    fi
  fi
done

# Bash completion
autoload -U +X bashcompinit && bashcompinit

AZCLI_COMPLETION="/etc/bash_completion.d/azure-cli"
if [[ -f ${AZCLI_COMPLETION} ]]; then
    source ${AZCLI_COMPLETION}
else
    echo "* ${AZCLI_COMPLETION:?} is missing"
fi

# complete -o nospace -C /usr/bin/x x
autocompletions=(
  terraform
)
for cmd in "${autocompletions[@]}"; do
  if [[ -n "${cmd}" ]]; then
    if command -v "${cmd}" &> /dev/null; then
      complete -o nospace -C "/usr/bin/${cmd}" "${cmd}"
    else
      echo "* ${cmd:?} is missing"
    fi
  fi
done

# Autocompletions from disk
if [[ -d "${USER_COMPLETIONS_DIR}" ]]; then
  if [[ ! $(find "${USER_COMPLETIONS_DIR}" -maxdepth 0 -empty) ]]; then
    for f in "${USER_COMPLETIONS_DIR}"/*; do
      if [[ -f ${f} ]]; then
        source "${f}"
      else
        echo "Unable to source '${f}'" 1>&2
      fi
    done
  fi
else
  echo "ERROR: ${USER_COMPLETIONS_DIR} does not exist!" 2>&1
fi

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
