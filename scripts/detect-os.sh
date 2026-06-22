#!/usr/bin/env bash
# Detect the operating system and environment

set -e

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ -n "$CODESPACES" ]]; then
        echo "codespaces"
    else
        echo "unknown"
    fi
}

detect_linux_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                echo "debian"
                ;;
            rhel|centos|fedora)
                echo "rhel"
                ;;
            *)
                echo "$ID"
                ;;
        esac
    else
        echo "unknown"
    fi
}

detect_shell() {
    basename "$SHELL"
}

# Export functions for use in other scripts
export -f detect_os
export -f detect_linux_distro
export -f detect_shell

# If sourced, don't print anything; if executed directly, print OS
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    detect_os
fi
