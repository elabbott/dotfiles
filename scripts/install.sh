#!/usr/bin/env bash
# Main installation script for dotfiles
# Usage: ./scripts/install.sh [--dry-run] [--skip-packages] [--skip-link]

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Flags
DRY_RUN=false
SKIP_PACKAGES=false
SKIP_LINK=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --skip-packages)
            SKIP_PACKAGES=true
            shift
            ;;
        --skip-link)
            SKIP_LINK=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Logging functions
log_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_header "🔧 Dotfiles Installation"

if [[ "$DRY_RUN" == "true" ]]; then
    log_warn "DRY RUN MODE - No changes will be made"
fi

# Source OS detection
source "${SCRIPT_DIR}/detect-os.sh"

OS=$(detect_os)
SHELL_NAME=$(detect_shell)

log_info "Detected OS: $OS"
log_info "Shell: $SHELL_NAME"

# Special handling for Windows
if [[ "$OS" == "wsl2" || "$OS" == "windows" ]]; then
    if [[ "$OS" == "wsl2" ]]; then
        log_info "Windows 11 Setup Method: WSL2 (Windows Subsystem for Linux 2)"
        log_header "🪟 Delegating to Windows WSL2 Setup Script"
        bash "${SCRIPT_DIR}/setup-windows-wsl2.sh" $@
        exit $?
    else
        log_info "Windows 11 Setup Method: Git Bash"
        log_header "🪟 Delegating to Windows Git Bash Setup Script"
        bash "${SCRIPT_DIR}/setup-windows-git-bash.sh" $@
        exit $?
    fi
fi

# Install packages based on OS (skip for Windows - delegated to specific scripts)
if [[ "$OS" != "wsl2" && "$OS" != "windows" ]]; then
    if [[ "$SKIP_PACKAGES" == "false" ]]; then
        log_header "📦 Installing Packages"

        case "$OS" in
            macos)
                if command -v brew &> /dev/null; then
                    log_info "Homebrew found"
                    if [[ -f "${DOTFILES_DIR}/macos/homebrew.txt" ]]; then
                        log_info "Installing Homebrew packages..."
                        if [[ "$DRY_RUN" != "true" ]]; then
                            while IFS= read -r package; do
                                [[ -z "$package" || "$package" =~ ^# ]] && continue
                                log_info "  - $package"
                                brew install "$package" 2>/dev/null || log_warn "    Failed to install $package"
                            done < "${DOTFILES_DIR}/macos/homebrew.txt"
                        fi
                    fi
                else
                    log_warn "Homebrew not found. Install from https://brew.sh"
                fi
                ;;
            linux)
                DISTRO=$(detect_linux_distro)
                log_info "Detected Linux distro: $DISTRO"

                case "$DISTRO" in
                    debian)
                        if [[ -f "${DOTFILES_DIR}/linux/apt-packages.txt" ]]; then
                            log_info "Installing apt packages..."
                            if [[ "$DRY_RUN" != "true" ]]; then
                                sudo apt-get update
                                while IFS= read -r package; do
                                    [[ -z "$package" || "$package" =~ ^# ]] && continue
                                    log_info "  - $package"
                                    sudo apt-get install -y "$package" || log_warn "    Failed to install $package"
                                done < "${DOTFILES_DIR}/linux/apt-packages.txt"
                            fi
                        fi
                        ;;
                    rhel)
                        if [[ -f "${DOTFILES_DIR}/linux/yum-packages.txt" ]]; then
                            log_info "Installing yum packages..."
                            if [[ "$DRY_RUN" != "true" ]]; then
                                while IFS= read -r package; do
                                    [[ -z "$package" || "$package" =~ ^# ]] && continue
                                    log_info "  - $package"
                                    sudo yum install -y "$package" || log_warn "    Failed to install $package"
                                done < "${DOTFILES_DIR}/linux/yum-packages.txt"
                            fi
                        fi
                        ;;
                    arch)
                        if [[ -f "${DOTFILES_DIR}/linux/pacman-packages.txt" ]]; then
                            log_info "Installing pacman packages..."
                            if [[ "$DRY_RUN" != "true" ]]; then
                                sudo pacman -Syu --noconfirm
                                while IFS= read -r package; do
                                    [[ -z "$package" || "$package" =~ ^# ]] && continue
                                    log_info "  - $package"
                                    sudo pacman -S --needed --noconfirm "$package" || log_warn "    Failed to install $package"
                                done < "${DOTFILES_DIR}/linux/pacman-packages.txt"
                            fi
                        fi
                        
                        # Check for AUR helper and install AUR packages
                        if command -v paru &> /dev/null || command -v yay &> /dev/null; then
                            if [[ -f "${DOTFILES_DIR}/linux/aur-packages.txt" ]]; then
                                log_info "Installing AUR packages..."
                                if [[ "$DRY_RUN" != "true" ]]; then
                                    AUR_HELPER=$(command -v paru || command -v yay)
                                    while IFS= read -r package; do
                                        [[ -z "$package" || "$package" =~ ^# ]] && continue
                                        log_info "  - $package (AUR)"
                                        $AUR_HELPER -S --needed --noconfirm "$package" || log_warn "    Failed to install $package"
                                    done < "${DOTFILES_DIR}/linux/aur-packages.txt"
                                fi
                            fi
                        else
                            log_warn "No AUR helper (paru/yay) found. Skipping AUR packages."
                            log_info "Install an AUR helper to install AUR packages: https://wiki.archlinux.org/title/AUR_helpers"
                        fi
                        ;;
                esac
                ;;
            codespaces)
                log_info "Running in GitHub Codespaces"
                ;;
            *)
                log_warn "Unknown OS: $OS"
                ;;
        esac
    else
        log_info "Skipping package installation"
    fi
fi

# Link dotfiles
if [[ "$SKIP_LINK" == "false" ]]; then
    log_header "🔗 Linking Dotfiles"
    if [[ "$DRY_RUN" == "true" ]]; then
        bash "${SCRIPT_DIR}/link-dotfiles.sh" "$DOTFILES_DIR" "true"
    else
        bash "${SCRIPT_DIR}/link-dotfiles.sh" "$DOTFILES_DIR" "false"
    fi
else
    log_info "Skipping dotfile linking"
fi

# Apply OS-specific configurations
case "$OS" in
    macos)
        log_header "🍎 macOS Configuration"
        if [[ -f "${DOTFILES_DIR}/macos/defaults.sh" ]]; then
            log_info "Applying macOS defaults..."
            if [[ "$DRY_RUN" != "true" ]]; then
                bash "${DOTFILES_DIR}/macos/defaults.sh"
            else
                log_info "[DRY RUN] Would run macOS defaults"
            fi
        fi
        ;;
esac

log_header "✅ Installation Complete!"
log_info "Dotfiles have been set up."

if [[ "$DRY_RUN" == "true" ]]; then
    log_info "Run without --dry-run to apply changes"
fi

# Print next steps
echo ""
log_info "Next steps:"
echo "  1. Review your shell configuration (e.g., ~/.zshrc)"
echo "  2. Restart your terminal or run: source ~/$SHELL_NAME<rc>"
echo "  3. Customize dotfiles as needed in $DOTFILES_DIR"
