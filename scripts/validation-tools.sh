#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

validate() {
    param_value=$(eval "echo \${${1}:=}")

    if [[ "${param_value}" == "" ]]; then
        echo "$1 value is missing, please specify it to run:"
        echo
        echo "   $1=cool-proj ... flex provision-project"
        echo
        exit 1
    fi
}
