#!/usr/bin/env bash

Populate KUBECONFIG
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

# Configure helm-diff
export HELM_DIFF_OUTPUT_CONTEXT=2
export HELM_DIFF_USE_UPGRADE_DRY_RUN=true
