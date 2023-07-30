#!/bin/bash

set -eu

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then
    sudo apt install zsh
    echo "Installing afx..."
    curl -sSL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash

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
    type deno > /dev/null 2>&1 || {
        echo "@ Installing deno..."
        echo "> curl -fsSL https://deno.land/x/install/install.sh | sh"
        curl -fsSL https://deno.land/x/install/install.sh | sh
    }
    set -e
fi

