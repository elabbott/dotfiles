#!/usr/bin/env bash
# Initialize GitHub Codespaces environment
# This script runs after the devcontainer is created

set -e

echo "[INFO] Initializing Codespaces environment..."

DOTFILES_DIR="${DOTFILES_DIR:-/workspaces/dotfiles}"

# Update package manager
apt-get update

# Install essential packages from Linux package list
if [[ -f "${DOTFILES_DIR}/linux/apt-packages.txt" ]]; then
    echo "[INFO] Installing apt packages..."
    while IFS= read -r package; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        echo "[INFO]   Installing $package..."
        apt-get install -y "$package" > /dev/null 2>&1 || echo "[WARN]   Failed to install $package"
    done < "${DOTFILES_DIR}/linux/apt-packages.txt"
fi

# Install zsh if not already installed
if ! command -v zsh &> /dev/null; then
    echo "[INFO] Installing zsh..."
    apt-get install -y zsh > /dev/null
fi

# Set zsh as default shell for vscode user
echo "[INFO] Setting zsh as default shell..."
chsh -s /bin/zsh vscode || true

# Link shell dotfiles to home directory
HOME_DIR="/home/vscode"
mkdir -p "${HOME_DIR}/.config/git"

echo "[INFO] Linking shell configurations..."
[[ -f "${DOTFILES_DIR}/shell/.zshrc" ]] && ln -sf "${DOTFILES_DIR}/shell/.zshrc" "${HOME_DIR}/.zshrc"
[[ -f "${DOTFILES_DIR}/shell/.bashrc" ]] && ln -sf "${DOTFILES_DIR}/shell/.bashrc" "${HOME_DIR}/.bashrc"

# Link git configuration
echo "[INFO] Linking git configuration..."
[[ -f "${DOTFILES_DIR}/git/config" ]] && ln -sf "${DOTFILES_DIR}/git/config" "${HOME_DIR}/.config/git/config"
[[ -f "${DOTFILES_DIR}/git/ignore" ]] && ln -sf "${DOTFILES_DIR}/git/ignore" "${HOME_DIR}/.gitignore_global"

# Create symbolic link to dotfiles in home directory for easy access
ln -sf "${DOTFILES_DIR}" "${HOME_DIR}/.dotfiles"

# Set permissions
chown -R vscode:vscode "${HOME_DIR}"

echo "[INFO] Codespaces environment initialized successfully!"
echo "[INFO] Dotfiles are available at ~/.dotfiles"
echo "[INFO] Configuration files have been linked"
