#!/bin/bash

set -eu

echo "Installing starship..."

type starship > /dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh

