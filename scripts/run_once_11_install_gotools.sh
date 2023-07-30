#!/bin/bash

set -eu

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then
    if ! type ghq > /dev/null 2>&1; then
        echo "## Installing ghq"
        echo "> go get github.com/x-motemen/ghq"
        go get github.com/x-motemen/ghq
    fi
fi

