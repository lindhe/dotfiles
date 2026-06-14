#!/usr/bin/env bash
# shellcheck disable=SC2329

TRUE_SHELL_ENV="$(readlink /proc/$$/exe | sed "s/.*\///")"

#########################     Populate KUBECONFIG     #########################
if command -v kubectl &> /dev/null; then
  DOTKUBE_DIR="${HOME}/.kube"
  if [ -d "${DOTKUBE_DIR}" ]; then
    export KUBECONFIG="${DOTKUBE_DIR}/config"
    if [[ "${TRUE_SHELL_ENV}" == "zsh" ]]; then
      setopt NULL_GLOB
    else
      shopt -s globstar
    fi
    for config in "${DOTKUBE_DIR}"/**/*.yaml; do
      export KUBECONFIG="${KUBECONFIG}:${config}"
    done
  else
    echo "${DOTKUBE_DIR} is missing"
  fi
fi

##########################     Configure difftool     ##########################
export KUBECTL_EXTERNAL_DIFF="diff -u --color=always"

#########################     Configure helm-diff     #########################
export HELM_DIFF_OUTPUT_CONTEXT=2
export HELM_DIFF_USE_UPGRADE_DRY_RUN=true

# If kubectl exists, enable completion:
if command -v kubectl &>/dev/null; then
  if [[ "${TRUE_SHELL_ENV}" == "zsh" ]]; then
    source <(kubectl completion zsh)
  else
    source <(kubectl completion bash)
    # Register completion for alias 'k' only if __start_kubectl exists
    if declare -F __start_kubectl &>/dev/null && alias k &>/dev/null; then
        complete -o default -F __start_kubectl k
    fi
  fi
fi

# If kustomize exists, enable completion:
if command -v kustomize &>/dev/null; then
  if [[ "${TRUE_SHELL_ENV}" == "zsh" ]]; then
    source <(kustomize completion zsh)
  else
    source <(kustomize completion bash)
  fi
fi
