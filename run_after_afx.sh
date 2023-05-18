#!/bin/bash

set -eu 

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then
    echo "Installing with afx..."

    afx install
    afx update
    afx uninstall
fi
