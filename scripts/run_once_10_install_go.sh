#!/bin/bash

set -eu

if [[ ! -z "${CHEZMOI_FULL_INSTALL:-}" ]]; then
    OS="$(uname -s)"
    ARCH="$(uname -m)"

    echo "## Go installation"

    echo "@ Checking latest go version..."
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
    echo "@ Downloading ${LATEST_GO_DOWNLOAD_URL}"
    wget ${LATEST_GO_DOWNLOAD_URL} -O /tmp/go.tar.gz
    echo "@ Extracting file..."
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    echo "> go version"
    go version
fi

