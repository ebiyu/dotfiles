#!/bin/bash

set -eu

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then

    OS="$(uname -s)"
    ARCH="$(uname -m)"
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
        if [ "$OS" == "Linux" -a "$ARCH" != "x86_64" ]; then
            echo "! Deno only support x86_64."
            echo "! Skip installing deno."
        else
            echo "> curl -fsSL https://deno.land/x/install/install.sh | sh"
            curl -fsSL https://deno.land/x/install/install.sh | sh
        fi
    }
    type wget > /dev/null 2>&1 || {
        echo "@ Installing wget..."
        echo "> sudo apt install wget"
        sudo apt install wget
    }
    type go > /dev/null 2>&1 || {
        echo "@ Checking go version..."
        LATEST_GO_VERSION="$(curl --silent 'https://go.dev/VERSION?m=text')";
        echo "@ Installing go version: ${LATEST_GO_VERSION}"

        case $OS in
            "Linux")
                case $ARCH in
                "x86_64")
                    ARCH=amd64
                    ;;
                "aarch64")
                    ARCH=arm64
                    ;;
                "armv6" | "armv7l")
                    ARCH=armv6l
                    ;;
                "armv8")
                    ARCH=arm64
                    ;;
                "i686")
                    ARCH=386
                    ;;
                .*386.*)
                    ARCH=386
                    ;;
                esac
                PLATFORM="linux-$ARCH"
            ;;
            "Darwin")
                  case $ARCH in
                  "x86_64")
                      ARCH=amd64
                      ;;
                  "arm64")
                      ARCH=arm64
                      ;;
                  esac
                PLATFORM="darwin-$ARCH"
            ;;
        esac
        echo "@ using platform: $PLATFORM"

        LATEST_GO_DOWNLOAD_URL="https://golang.org/dl/${LATEST_GO_VERSION}.${PLATFORM}.tar.gz"
        echo "> Downloading ${LATEST_GO_DOWNLOAD_URL}"
        wget ${LATEST_GO_DOWNLOAD_URL} -O /tmp/go.tar.gz
        echo "> Extracting file..."
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/go.tar.gz
        go version
    }
    if ! type ghq > /dev/null 2>&1; then
        echo "@ Installing ghq..."
        echo "> go get github.com/x-motemen/ghq"
        go get github.com/x-motemen/ghq
    fi
    set -e
fi

