#!/usr/bin/env bash

set -euo pipefail

stderr() {
    echo "${@}" 1>&2
}

fail() {
    stderr "${1}"
    stderr ""
    stderr "Exiting …"
    exit "${2:-1}"
}

if [[ $# -ne 1 ]]; then
    stderr ""
    stderr "USAGE:"
    stderr "    ${0} FOO"
    stderr ""
    exit 0
fi
