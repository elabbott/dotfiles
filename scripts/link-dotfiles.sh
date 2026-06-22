#!/usr/bin/env bash
# Create symlinks for dotfiles in home directory

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
    link_file "${DOTFILES_DIR}/git/config" "$HOME/.config/git/config"
fi

if [[ -f "${DOTFILES_DIR}/git/ignore" ]]; then
    link_file "${DOTFILES_DIR}/git/ignore" "$HOME/.gitignore_global"
fi

# Add more linking rules as dotfiles are created

log_info "Dotfiles linked successfully!"
