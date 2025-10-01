#!/usr/bin/env bash
# shellcheck disable=SC2329

declare -A DISALLOWED_TMUX_TERMINALS=(
    [tmux]=1
    [vscode]=1
)
readonly DISALLOWED_TMUX_TERMINALS

if [[ -n "${DISALLOWED_TMUX_TERMINALS[TERM_PROGRAM]}" ]]; then
    echo "Do you want to run TMUX? [y/N]"
    read -rq SHOULD_RUN_TMUX
    echo -e "\n"
    if [[ "${SHOULD_RUN_TMUX}" == y ]]; then
        tmux
    fi
fi
