#!/usr/bin/env bash
# Setup script for Windows 11 using WSL2 (Windows Subsystem for Linux 2)
# This script is called from install.sh when running in WSL2
# Usage: bash setup-windows-wsl2.sh [--dry-run]

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Flags
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
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

log_step() {
    echo -e "${CYAN}→${NC} $1"
}

# Check WSL2 compatibility
check_wsl2_environment() {
    log_header "🔍 Checking WSL2 Environment"
    
    # Check WSL version
    if grep -qi microsoft /proc/version 2>/dev/null || grep -qi "wsl" /proc/version 2>/dev/null; then
        log_info "✓ Running in WSL2"
    else
        log_error "Not running in WSL2. Please enable WSL2 first."
        echo "  Instructions: https://docs.microsoft.com/en-us/windows/wsl/install"
        exit 1
    fi
    
    # Check for required tools
    log_step "Checking required tools..."
    
    if ! command -v git &> /dev/null; then
        log_error "Git not found. Please install git first."
        exit 1
    fi
    log_info "✓ Git is available"
    
    if ! command -v bash &> /dev/null; then
        log_error "Bash not found."
        exit 1
    fi
    log_info "✓ Bash is available"
}

# Verify file locations
verify_wsl2_locations() {
    log_header "📍 Verifying File Locations"
    
    log_step "Checking home directory..."
    if [[ ! -d "$HOME" ]]; then
        log_error "Home directory not found: $HOME"
        exit 1
    fi
    log_info "Home directory: $HOME"
    
    log_step "Checking dotfiles location..."
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        log_error "Dotfiles directory not found: $DOTFILES_DIR"
        exit 1
    fi
    log_info "Dotfiles location: $DOTFILES_DIR"
    
    # Verify dotfiles are in WSL home, not in /mnt/ (Windows filesystem)
    if [[ "$DOTFILES_DIR" == /mnt/* ]]; then
        log_warn "Dotfiles are on Windows filesystem (/mnt/)"
        log_warn "This may cause symlink issues. Consider moving to WSL home:"
        log_warn "  cp -r $DOTFILES_DIR ~/.dotfiles"
        log_warn "  cd ~/.dotfiles"
    fi
}

# Install packages for WSL2
install_wsl2_packages() {
    log_header "📦 Installing Packages for WSL2"
    
    log_step "Detecting Linux distribution..."
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO="$ID"
        log_info "Distribution: $DISTRO"
    else
        log_warn "Could not detect Linux distribution"
        return 0
    fi
    
    case "$DISTRO" in
        ubuntu|debian)
            log_step "Installing packages via apt..."
            if [[ "$DRY_RUN" != "true" ]]; then
                sudo apt-get update
                if [[ -f "${DOTFILES_DIR}/linux/apt-packages.txt" ]]; then
                    while IFS= read -r package; do
                        [[ -z "$package" || "$package" =~ ^# ]] && continue
                        log_info "  Installing: $package"
                        sudo apt-get install -y "$package" 2>/dev/null || log_warn "    Failed to install $package"
                    done < "${DOTFILES_DIR}/linux/apt-packages.txt"
                fi
            else
                log_info "[DRY RUN] Would run: sudo apt-get update"
                if [[ -f "${DOTFILES_DIR}/linux/apt-packages.txt" ]]; then
                    log_info "[DRY RUN] Would install packages from linux/apt-packages.txt"
                fi
            fi
            ;;
        rhel|centos|fedora)
            log_step "Installing packages via yum..."
            if [[ "$DRY_RUN" != "true" ]]; then
                if [[ -f "${DOTFILES_DIR}/linux/yum-packages.txt" ]]; then
                    while IFS= read -r package; do
                        [[ -z "$package" || "$package" =~ ^# ]] && continue
                        log_info "  Installing: $package"
                        sudo yum install -y "$package" || log_warn "    Failed to install $package"
                    done < "${DOTFILES_DIR}/linux/yum-packages.txt"
                fi
            else
                log_info "[DRY RUN] Would install packages from linux/yum-packages.txt"
            fi
            ;;
        *)
            log_warn "Unsupported distribution: $DISTRO"
            ;;
    esac
}

# Setup shell configuration for WSL2
setup_wsl2_shell() {
    log_header "🐚 Setting Up Shell Configuration"
    
    # Detect shell
    SHELL_NAME=$(basename "$SHELL")
    log_info "Current shell: $SHELL_NAME"
    
    case "$SHELL_NAME" in
        zsh)
            log_step "Configuring Zsh..."
            if [[ "$DRY_RUN" != "true" ]]; then
                if [[ ! -f "$HOME/.zshrc" ]]; then
                    touch "$HOME/.zshrc"
                fi
                
                # Add dotfiles sourcing if not already present
                if ! grep -q "dotfiles/shell" "$HOME/.zshrc"; then
                    {
                        echo ""
                        echo "# Dotfiles configuration"
                        echo "export PATH=\"\$HOME/.dotfiles/bin:\$PATH\""
                        echo "source \$HOME/.dotfiles/shell/aliases.sh"
                        echo "source \$HOME/.dotfiles/shell/exports.sh"
                        echo "source \$HOME/.dotfiles/shell/functions.sh"
                    } >> "$HOME/.zshrc"
                    log_info "Added dotfiles sourcing to ~/.zshrc"
                fi
            else
                log_info "[DRY RUN] Would configure ~/.zshrc"
            fi
            ;;
        bash)
            log_step "Configuring Bash..."
            if [[ "$DRY_RUN" != "true" ]]; then
                if [[ ! -f "$HOME/.bashrc" ]]; then
                    touch "$HOME/.bashrc"
                fi
                
                # Add dotfiles sourcing if not already present
                if ! grep -q "dotfiles/shell" "$HOME/.bashrc"; then
                    {
                        echo ""
                        echo "# Dotfiles configuration"
                        echo "export PATH=\"\$HOME/.dotfiles/bin:\$PATH\""
                        echo "source \$HOME/.dotfiles/shell/aliases.sh"
                        echo "source \$HOME/.dotfiles/shell/exports.sh"
                        echo "source \$HOME/.dotfiles/shell/functions.sh"
                    } >> "$HOME/.bashrc"
                    log_info "Added dotfiles sourcing to ~/.bashrc"
                fi
            else
                log_info "[DRY RUN] Would configure ~/.bashrc"
            fi
            ;;
        *)
            log_warn "Unsupported shell: $SHELL_NAME"
            ;;
    esac
}

# Create symlinks in WSL2
link_files_wsl2() {
    log_header "🔗 Creating Symlinks"
    
    create_symlink() {
        local src="$1"
        local dest="$2"
        
        if [[ "$DRY_RUN" == "true" ]]; then
            log_info "[DRY RUN] Would link: $src -> $dest"
            return 0
        fi
        
        # Create parent directory if needed
        mkdir -p "$(dirname "$dest")"
        
        # Handle existing files
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            BACKUP_DIR="$DOTFILES_DIR/.backups"
            mkdir -p "$BACKUP_DIR"
            BACKUP_FILE="${BACKUP_DIR}/$(basename "$dest").$(date +%s).bak"
            log_warn "Backing up existing $dest to $BACKUP_FILE"
            mv "$dest" "$BACKUP_FILE"
        fi
        
        # Remove existing symlink
        if [[ -L "$dest" ]]; then
            rm "$dest"
        fi
        
        # Create symlink
        ln -s "$src" "$dest"
        log_info "Linked: $dest"
    }
    
    # Shell configuration files
    log_step "Linking shell configuration..."
    if [[ -f "${DOTFILES_DIR}/shell/aliases.sh" ]]; then
        create_symlink "${DOTFILES_DIR}/shell/aliases.sh" "$HOME/.bash_aliases"
    fi
    if [[ -f "${DOTFILES_DIR}/shell/functions.sh" ]]; then
        create_symlink "${DOTFILES_DIR}/shell/functions.sh" "$HOME/.bash_functions"
    fi
    
    # Git configuration
    log_step "Linking git configuration..."
    if [[ -f "${DOTFILES_DIR}/git/config" ]]; then
        create_symlink "${DOTFILES_DIR}/git/config" "$HOME/.config/git/config"
    fi
    if [[ -f "${DOTFILES_DIR}/git/ignore" ]]; then
        create_symlink "${DOTFILES_DIR}/git/ignore" "$HOME/.gitignore_global"
    fi
}

# Setup Windows Terminal integration (informational)
setup_terminal_integration() {
    log_header "🖥️  Windows Terminal Integration"
    
    log_info "To optimize Windows Terminal for WSL2:"
    echo ""
    echo "  1. Open Windows Terminal settings (Ctrl+,)"
    echo "  2. Go to Defaults profile settings"
    echo "  3. Set your preferred distribution under 'Default profile'"
    echo "  4. Adjust font (recommended: Cascadia Code)"
    echo "  5. Enable 'Copy on select' under Interaction"
    echo ""
    log_info "After completing setup, restart Windows Terminal"
}

# Verify installation
verify_wsl2_setup() {
    log_header "✅ Verifying Setup"
    
    local all_good=true
    
    log_step "Checking dotfiles location..."
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_info "✓ Dotfiles found at $DOTFILES_DIR"
    else
        log_error "✗ Dotfiles not found at $DOTFILES_DIR"
        all_good=false
    fi
    
    log_step "Checking PATH..."
    if echo "$PATH" | grep -q "$DOTFILES_DIR/bin"; then
        log_info "✓ Dotfiles bin in PATH"
    else
        log_warn "⚠ Dotfiles bin not in PATH. Run: source ~/.bashrc or ~/.zshrc"
    fi
    
    log_step "Checking git configuration..."
    if git config --global user.name &>/dev/null; then
        GIT_NAME=$(git config --global user.name)
        log_info "✓ Git user.name: $GIT_NAME"
    else
        log_warn "⚠ Git user.name not set. Run: git config --global user.name 'Your Name'"
    fi
    
    log_step "Checking shell config..."
    SHELL_NAME=$(basename "$SHELL")
    if [[ "$SHELL_NAME" == "zsh" ]]; then
        RC_FILE="$HOME/.zshrc"
    else
        RC_FILE="$HOME/.bashrc"
    fi
    
    if [[ -f "$RC_FILE" ]]; then
        log_info "✓ Shell config found at $RC_FILE"
    else
        log_warn "⚠ Shell config not found at $RC_FILE"
    fi
    
    if [[ "$all_good" == "true" ]]; then
        log_info "All checks passed!"
    else
        log_warn "Some checks failed. Please review the output above."
    fi
}

# Main execution
log_header "🪟 Windows 11 WSL2 Setup"

check_wsl2_environment
verify_wsl2_locations
install_wsl2_packages
setup_wsl2_shell
link_files_wsl2
setup_terminal_integration
verify_wsl2_setup

echo ""
log_header "✨ WSL2 Setup Complete!"
log_info "Next steps:"
echo "  1. Reload your shell: source ~/.bashrc (or ~/.zshrc)"
echo "  2. Configure git identity: git config --global user.name 'Your Name'"
echo "  3. Read CUSTOMIZATION_GUIDE.md to personalize your setup"
echo ""
