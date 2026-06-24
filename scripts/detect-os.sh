#!/usr/bin/env bash
# Detect the operating system and environment

set -e

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "linux"* ]]; then
        # Check if running under WSL2
        if grep -qi microsoft /proc/version 2>/dev/null || grep -qi "wsl" /proc/version 2>/dev/null; then
            echo "wsl2"
        else
            echo "linux"
        fi
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        echo "windows"
    elif [[ -n "$CODESPACES" ]]; then
        echo "codespaces"
    else
        echo "unknown"
    fi
}

detect_windows_setup_method() {
    # Detect which Windows setup method to use
    if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "linux"* ]]; then
        if grep -qi microsoft /proc/version 2>/dev/null || grep -qi "wsl" /proc/version 2>/dev/null; then
            echo "wsl2"
        fi
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        echo "git-bash"
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
            arch|manjaro|endeavouros)
                echo "arch"
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
export -f detect_windows_setup_method

# If sourced, don't print anything; if executed directly, print OS
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    detect_os
fi
