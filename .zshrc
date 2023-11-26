# vim: foldmethod=marker

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

############################     TODO-file init     ############################
# {{{
TODOFILE=~/TODO.zsh.md
# Clear the TODO-file
rm --force ${TODOFILE}
# }}}

############################     Bootstrap OMZ     ############################
# {{{

if [ ! -d "${ZSH}" ]; then
  if command -v curl &> /dev/null; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "* curl is missing" >> ${TODOFILE}
    if command -v wget &> /dev/null; then
      sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    else
      echo "* wget is missing" >> ${TODOFILE}
      exit 1
    fi
  fi
fi

# }}}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# ZSH_THEME_RANDOM_CANDIDATES=($(<~/.zsh_favlist))

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  dotenv
  git
)

source $ZSH/oh-my-zsh.sh

##########################     Fix OMZ behaviour     ##########################
# {{{

# https://superuser.com/a/1447349/110087
unset LESS;

# https://github.com/ohmyzsh/ohmyzsh/issues/2537#issuecomment-35693367
setopt no_share_history

# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#hist_stamps
export HIST_STAMPS="yyyy-mm-dd"

# Remove annoying backward-kill-word
# https://stackoverflow.com/questions/39428667/how-to-remove-a-keybinding
bindkey -r '^[^H'

# Set some custom variables
AUTOCOMPLETE_DIR="${HOME}/.config/zsh/autocomplete"
mkdir -p "${AUTOCOMPLETE_DIR}"

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

##############################     Functions     ##############################
# {{{
ZSH_FUNCTIONS=~/.zsh_functions
if [[ -f ${ZSH_FUNCTIONS} ]]; then
    source ${ZSH_FUNCTIONS}
else
    echo "* ${ZSH_FUNCTIONS} is missing" >> ${TODOFILE}
fi
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

################################     Server     ################################
# {{{
ZSH_SERVER="${HOME}/.zsh_server"
if [[ -f ${ZSH_SERVER} ]]; then
    source ${ZSH_SERVER}
else
    echo "* ${ZSH_SERVER} is missing" >> ${TODOFILE}
fi
# }}}

#################################     k8s     #################################
# {{{
ZSH_K8S=~/.zsh_k8s
if [[ -f ${ZSH_K8S} ]]; then
    source ${ZSH_K8S}
else
    echo "* ${ZSH_K8S} is missing" >> ${TODOFILE}
fi
# }}}

###############################     Bindkeys     ###############################
# {{{

bindkey '^[M' '_toggle_md_mode'
bindkey -s '^[R' 'exec zsh'

# }}}

##############################     Completion     ##############################
# {{{

# x completion zsh
autocompletions=(
  ${X_COMPLETION_ZSH}
)
for cmd in ${autocompletions}; do
  if command -v "${cmd}" &> /dev/null; then
    cache "${cmd} completion zsh > ${AUTOCOMPLETE_DIR}/${cmd}.zsh" 240
  else
    echo "* ${cmd} is missing" >> ${TODOFILE}
  fi
done

# x completion -s zsh
autocompletions=(
  gh
)
for cmd in ${autocompletions}; do
  if command -v "${cmd}" &> /dev/null; then
    cache "${cmd} completion -s zsh > ${AUTOCOMPLETE_DIR}/${cmd}.zsh" 240
  else
    echo "* ${cmd} is missing" >> ${TODOFILE}
  fi
done

# x shell-completion zsh
autocompletions=(
  yq
)
for cmd in ${autocompletions}; do
  if command -v "${cmd}" &> /dev/null; then
    cache "${cmd} shell-completion zsh > ${AUTOCOMPLETE_DIR}/${cmd}.zsh" 240
  else
    echo "* ${cmd} is missing" >> ${TODOFILE}
  fi
done

# Bash completion
autoload -U +X bashcompinit && bashcompinit

AZCLI_COMPLETION="/etc/bash_completion.d/azure-cli"
if [[ -f ${AZCLI_COMPLETION} ]]; then
    source ${AZCLI_COMPLETION}
else
    echo "* ${AZCLI_COMPLETION:?} is missing" >> ${TODOFILE}
fi

# complete -o nospace -C /usr/bin/x x
autocompletions=(
  terraform
)
for cmd in ${autocompletions}; do
  if command -v "${cmd}" &> /dev/null; then
    complete -o nospace -C "/usr/bin/${cmd}" "${cmd}"
  else
    echo "* ${cmd} is missing" >> ${TODOFILE}
  fi
done

# Autocompletions from disk
if [[ -d "${AUTOCOMPLETE_DIR}" ]]; then
  if [[ ! $(find "${AUTOCOMPLETE_DIR}" -maxdepth 0 -empty) ]]; then
    for f in ${AUTOCOMPLETE_DIR}/*; do
      if [[ -f ${f} ]]; then
        source ${f}
      else
        echo "Unable to source '${f}'" 1>&2
      fi
    done
  fi
else
  echo "ERROR: ${AUTOCOMPLETE_DIR} does not exist!" 2>&1
fi

# }}}

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
