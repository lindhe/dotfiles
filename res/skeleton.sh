#!/usr/bin/env bash

set -euo pipefail

debug() {
    echo "${@}" 1>&2
}

fail() {
    debug "${1}"
    exit "${2:-1}"
}

if [[ $# -ne 2 ]]; then
    debug ""
    debug "USAGE:"
    debug "    ${0} SSID PASSWORD"
    debug ""
    exit 0
fi
