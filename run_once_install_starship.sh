#!/bin/bash

set -eu

# if not installed
if ! type starship > /dev/null 2>&1; then
  echo "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh
fi


