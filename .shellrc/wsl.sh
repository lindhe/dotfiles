#!/usr/bin/env bash
# vim: foldmethod=marker
# shellcheck disable=SC2329

if [[ -n ${WSLENV+x} ]]; then

    if ! command -v wslpath &> /dev/null; then
        echo "wslpath not found! 🛑" 1>&2
    fi

    # Open new tabs in the same directory
    # https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory#zsh
    keep_current_path() {
      printf "\e]9;9;%s\e\\" "$(wslpath -w "${PWD}")"
    }
    precmd_functions+=(keep_current_path)

    if command -v docker &> /dev/null; then
        # Check if docker service exists
        if service --status-all |& grep -qE ' docker$'; then
            # Start the docker service unless it's already running
            if ! service docker status > /dev/null ; then
                echo "Service docker not running!"
                echo "service docker start ..."
                sudo service docker start
            fi
        else
            echo "* service docker is missing"
        fi
    fi

    # Configure some path helpers
    if command -v powershell.exe &> /dev/null; then

        WHOME_WIN="$(powershell.exe '[System.Environment]::GetFolderPath("UserProfile")' | tr -d '\r')"
        WHOME_WIN_ESCAPED="$(printf '%q' "${WHOME_WIN}")"
        WHOME="$(wslpath "${WHOME_WIN_ESCAPED}")"
        whome() {
            echo "${WHOME}"
        }

        WDOWNLOADS="${WHOME}/Downloads"
        wdownloads() {
            echo "${WDOWNLOADS}"
        }

    else
        echo '* powershell.exe is missing'
        echo 'Unable to set Windows path helpers!' 1>&2
    fi

fi
