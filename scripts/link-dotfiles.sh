#!/usr/bin/env bash
# Create symlinks for dotfiles in home directory
# Supports macOS, Linux, WSL2, and provides alternatives for Git Bash

set -e

DOTFILES_DIR="${1:-.}"
DRY_RUN="${2:-false}"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect environment for symlink handling
detect_link_environment() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        echo "git-bash"
    elif grep -qi microsoft /proc/version 2>/dev/null || grep -qi "wsl" /proc/version 2>/dev/null; then
        echo "wsl2"
    else
        echo "unix"
    fi
}

LINK_ENV=$(detect_link_environment)
log_info "Link environment: $LINK_ENV"

link_file() {
    local src="$1"
    local dest="$2"
    local backup_dir="${DOTFILES_DIR}/.backups"

    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "[DRY RUN] Would link: $src -> $dest"
        return 0
    fi

    # Create backup directory if needed
    if [[ -e "$dest" && ! -L "$dest" ]]; then
        mkdir -p "$backup_dir"
        backup_file="${backup_dir}/$(basename "$dest").$(date +%s).bak"
        log_warn "Backing up existing $dest to $backup_file"
        mv "$dest" "$backup_file"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Create symlink
    if [[ -L "$dest" ]]; then
        # Remove existing symlink
        rm "$dest"
    fi

    ln -s "$src" "$dest"
    log_info "Linked: $src -> $dest"
}

# Shell configurations
if [[ -f "${DOTFILES_DIR}/shell/.zshrc" ]]; then
    link_file "${DOTFILES_DIR}/shell/.zshrc" "$HOME/.zshrc"
fi

if [[ -f "${DOTFILES_DIR}/shell/.bashrc" ]]; then
    link_file "${DOTFILES_DIR}/shell/.bashrc" "$HOME/.bashrc"
fi

# Git configuration
if [[ -f "${DOTFILES_DIR}/git/config" ]]; then
    mkdir -p "$HOME/.config/git"
    if [[ "$LINK_ENV" == "git-bash" ]]; then
        # Git Bash has limited symlink support, use copy instead
        if [[ "$DRY_RUN" == "true" ]]; then
            log_info "[DRY RUN] Would copy (not link) git config for Git Bash compatibility"
        else
            cp "${DOTFILES_DIR}/git/config" "$HOME/.config/git/config"
            log_info "Copied (not linked) git config for Git Bash compatibility"
        fi
    else
        link_file "${DOTFILES_DIR}/git/config" "$HOME/.config/git/config"
    fi
fi

if [[ -f "${DOTFILES_DIR}/git/ignore" ]]; then
    if [[ "$LINK_ENV" == "git-bash" ]]; then
        # Git Bash has limited symlink support, use copy instead
        if [[ "$DRY_RUN" == "true" ]]; then
            log_info "[DRY RUN] Would copy (not link) git ignore for Git Bash compatibility"
        else
            cp "${DOTFILES_DIR}/git/ignore" "$HOME/.gitignore_global"
            log_info "Copied (not linked) git ignore for Git Bash compatibility"
        fi
    else
        link_file "${DOTFILES_DIR}/git/ignore" "$HOME/.gitignore_global"
    fi
fi

# Add more linking rules as dotfiles are created

if [[ "$LINK_ENV" == "git-bash" ]]; then
    log_warn "Running in Git Bash: Some symlinks were copied instead due to Windows limitations"
fi

log_info "Dotfiles linked successfully!"
