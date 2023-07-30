#!/bin/bash

set -eu

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then
    set +e
    type zsh > /dev/null 2>&1 || {
        echo "@ Installing zsh..."
        echo "> sudo apt install zsh"
        sudo apt install zsh
    }
    type peco > /dev/null 2>&1 || {
        echo "@ Installing peco..."
        echo "> sudo apt install peco"
        sudo apt install peco
    }
    type wget > /dev/null 2>&1 || {
        echo "@ Installing wget..."
        echo "> sudo apt install wget"
        sudo apt install wget
    }
    set -e
fi

