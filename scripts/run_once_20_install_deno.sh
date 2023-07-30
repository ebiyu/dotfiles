#!/bin/bash

set -eu

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then
    OS="$(uname -s)"
    ARCH="$(uname -m)"
    echo "@ Installing deno..."
    if [ "$OS" == "Linux" -a "$ARCH" != "x86_64" ]; then
        echo "! Deno only support x86_64."
        echo "! Skip installing deno."
    else
        echo "> curl -fsSL https://deno.land/x/install/install.sh | sh"
        curl -fsSL https://deno.land/x/install/install.sh | sh
    fi
fi

