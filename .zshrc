# shellcheck disable=SC2148,SC1090,SC2034
# vim: foldmethod=marker

################################     zinit     ################################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

###############################     Plugins     ###############################

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# zinit snippet OMZL::git.zsh
zinit snippet OMZP::command-not-found
zinit snippet OMZP::helm
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::sudo

###############################     History     ###############################
HISTSIZE=9999
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

###############################     exports     ###############################
path+=/opt/nvim-linux64/bin
# By exporting PATH via `typeset -TUx PATH path`, there are no duplicates.
# With this in place, PATH can safely be updated by running `path+=/tmp/foo`
#
# Stolen from here:
# https://stackoverflow.com/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh/18077919#comment72796046_18077919
typeset -TUx PATH path

################################     prompt     ################################
if [ ! command -v oh-my-posh &> /dev/null ]; then
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi
eval "$(oh-my-posh init zsh --config ~/.config/omp/config.yaml)"

###############################     Aliases     ###############################
# {{{
ZSH_ALIASES=~/.zsh_aliases
if [[ -f ${ZSH_ALIASES} ]]; then
    source ${ZSH_ALIASES}
else
    echo "* ${ZSH_ALIASES:?} is missing"
fi
# }}}

##############################     Functions     ##############################
# {{{
ZSH_FUNCTIONS=~/.zsh_functions
if [[ -f ${ZSH_FUNCTIONS} ]]; then
    source ${ZSH_FUNCTIONS}
else
    echo "* ${ZSH_FUNCTIONS:?} is missing"
fi
# }}}

#################################     WSL2     #################################
# {{{
ZSH_WSL=~/.zsh_wsl
if [[ -f ${ZSH_WSL} ]]; then
    source "${ZSH_WSL}"
else
    echo "* ${ZSH_WSL:?} is missing"
fi
# }}}

#################################     k8s     #################################
# {{{
ZSH_K8S=~/.zsh_k8s
if [[ -f ${ZSH_K8S} ]]; then
    source ${ZSH_K8S}
else
    echo "* ${ZSH_K8S:?} is missing"
fi
# }}}

#################################    Server    #################################
# {{{
ZSH_SERVER=~/.zsh_server
if [[ -f ${ZSH_SERVER} ]]; then
    source "${ZSH_SERVER}"
fi
# }}}

###############################     Bindkeys     ###############################
# {{{

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
  if command -v "${cmd}" &> /dev/null; then
    ${cmd} completion zsh > "${USER_COMPLETIONS_DIR}/${cmd}.zsh"
  else
    echo "* ${cmd:?} is missing"
  fi
done

# x completion -s zsh
autocompletions=(
  gh
)
for cmd in "${autocompletions[@]}"; do
  if command -v "${cmd}" &> /dev/null; then
    ${cmd} completion -s zsh > "${USER_COMPLETIONS_DIR}/${cmd}.zsh"
  else
    echo "* ${cmd:?} is missing"
  fi
done

# x shell-completion zsh
autocompletions=(
  yq
)
for cmd in "${autocompletions[@]}"; do
  if command -v "${cmd}" &> /dev/null; then
    ${cmd} shell-completion zsh > "${USER_COMPLETIONS_DIR}/${cmd}.zsh"
  else
    echo "* ${cmd:?} is missing"
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
  if command -v "${cmd}" &> /dev/null; then
    complete -o nospace -C "/usr/bin/${cmd}" "${cmd}"
  else
    echo "* ${cmd:?} is missing"
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

autoload -Uz compinit && compinit
zinit cdreplay -q

# }}}

###############################     VS Code     ###############################
if [[ "${TERM_PROGRAM}" == "vscode" ]]; then
  export EDITOR='code --wait'
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


# # Completion styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
