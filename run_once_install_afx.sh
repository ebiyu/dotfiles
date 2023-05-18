#!/bin/bash

set -eu

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then
    echo "Installing afx..."
    curl -sSL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash
fi

