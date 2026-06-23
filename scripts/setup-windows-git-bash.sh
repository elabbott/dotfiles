#!/usr/bin/env bash
# Setup script for Windows 11 using Git Bash
# This script is called from install.sh when running in Git Bash
# Usage: bash setup-windows-git-bash.sh [--dry-run]

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Color output (limited support in Git Bash)
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

# Check Git Bash environment
check_git_bash_environment() {
    log_header "🔍 Checking Git Bash Environment"
    
    # Check for Git Bash indicators
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$TERM_PROGRAM" == "mintty" ]]; then
        log_info "✓ Running in Git Bash"
    else
        log_warn "⚠ Unexpected environment. This setup is optimized for Git Bash."
    fi
    
    # Check for required tools
    log_step "Checking required tools..."
    
    if ! command -v git &> /dev/null; then
        log_error "Git not found. Please install Git for Windows first."
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
verify_git_bash_locations() {
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
    
    # Note: In Git Bash, all paths are Windows paths mapped to Unix-like paths
    log_step "File system type: Windows filesystem via Git Bash"
    log_info "Using MSYS2 compatibility layer"
}

# Setup shell configuration for Git Bash
setup_git_bash_shell() {
    log_header "🐚 Setting Up Shell Configuration"
    
    log_info "Git Bash uses Bash shell"
    
    log_step "Configuring .bashrc..."
    if [[ "$DRY_RUN" != "true" ]]; then
        if [[ ! -f "$HOME/.bashrc" ]]; then
            touch "$HOME/.bashrc"
        fi
        
        # Add dotfiles sourcing if not already present
        if ! grep -q "dotfiles" "$HOME/.bashrc" 2>/dev/null; then
            {
                echo ""
                echo "# Dotfiles configuration"
                echo "export PATH=\"\$HOME/.dotfiles/bin:\$PATH\""
                echo "source \$HOME/.dotfiles/shell/aliases.sh"
                echo "source \$HOME/.dotfiles/shell/exports.sh"
                echo "source \$HOME/.dotfiles/shell/functions.sh"
                echo ""
                echo "# Git Bash specific settings"
                echo "export TERM=xterm-256color"
            } >> "$HOME/.bashrc"
            log_info "✓ Added dotfiles sourcing to ~/.bashrc"
        else
            log_info "✓ Dotfiles already configured in ~/.bashrc"
        fi
    else
        log_info "[DRY RUN] Would configure ~/.bashrc"
    fi
}

# Create shell configuration files if they don't exist
create_shell_configs() {
    log_header "📄 Creating Shell Configuration Files"
    
    create_bash_file() {
        local filepath="$1"
        local description="$2"
        
        if [[ ! -f "$filepath" ]]; then
            if [[ "$DRY_RUN" != "true" ]]; then
                mkdir -p "$(dirname "$filepath")"
                touch "$filepath"
                log_info "✓ Created $description: $filepath"
            else
                log_info "[DRY RUN] Would create $description: $filepath"
            fi
        else
            log_info "✓ Already exists: $description"
        fi
    }
    
    create_bash_file "$HOME/.bash_profile" ".bash_profile"
    create_bash_file "$HOME/.bash_aliases" ".bash_aliases"
    create_bash_file "$HOME/.bash_functions" ".bash_functions"
}

# Setup symlinks for Git Bash (with Windows path handling)
link_files_git_bash() {
    log_header "🔗 Setting Up Configuration Files"
    
    log_step "Git Bash symlink note:"
    log_info "Full symlinks may have limited support on Windows."
    log_info "Using source-based approach instead."
    
    echo ""
    
    # Create Windows-compatible approach using source
    if [[ "$DRY_RUN" != "true" ]]; then
        
        # Git configuration
        log_step "Setting up git configuration..."
        mkdir -p "$HOME/.config/git"
        
        if [[ -f "${DOTFILES_DIR}/git/config" ]]; then
            # For Windows, copy the file instead of symlinking
            cp "${DOTFILES_DIR}/git/config" "$HOME/.config/git/config"
            log_info "✓ Copied git config"
        fi
        
        if [[ -f "${DOTFILES_DIR}/git/ignore" ]]; then
            cp "${DOTFILES_DIR}/git/ignore" "$HOME/.gitignore_global"
            log_info "✓ Copied git ignore file"
        fi
        
        # Configure git to use the global ignore file
        git config --global core.excludesfile "$HOME/.gitignore_global" 2>/dev/null || true
        
    else
        log_info "[DRY RUN] Would set up git configuration"
    fi
}

# Setup Git for Windows specifics
setup_git_windows() {
    log_header "🔧 Git for Windows Configuration"
    
    log_step "Checking git configuration..."
    
    if [[ "$DRY_RUN" != "true" ]]; then
        
        # Check and warn if git identity not set
        if ! git config --global user.name &>/dev/null; then
            log_warn "Git user.name not set"
            log_info "Run: git config --global user.name 'Your Name'"
        else
            GIT_NAME=$(git config --global user.name)
            log_info "✓ Git user.name: $GIT_NAME"
        fi
        
        if ! git config --global user.email &>/dev/null; then
            log_warn "Git user.email not set"
            log_info "Run: git config --global user.email 'your.email@example.com'"
        else
            GIT_EMAIL=$(git config --global user.email)
            log_info "✓ Git user.email: $GIT_EMAIL"
        fi
        
        # Set line ending handling for Windows
        log_step "Configuring line endings..."
        git config --global core.autocrlf false || true
        log_info "✓ Line ending handling configured"
        
    else
        log_info "[DRY RUN] Would verify git configuration"
    fi
}

# Create helper batch script for Windows Terminal integration
create_windows_helpers() {
    log_header "🖥️  Creating Windows Integration Helpers"
    
    # Note: We can't directly create .bat files from bash, but we can provide instructions
    log_info "Windows Terminal integration:"
    echo ""
    echo "  To open Git Bash from Windows Terminal:"
    echo "  1. Open Windows Terminal"
    echo "  2. Click Settings (Ctrl+,)"
    echo "  3. Add a new profile with:"
    echo ""
    echo "     \"name\": \"Git Bash\","
    echo "     \"commandline\": \"C:\\\\Program Files\\\\Git\\\\bin\\\\bash.exe -i -l\","
    echo ""
    echo "  4. Set it as default if desired"
    echo ""
}

# Show limitations and recommendations
show_git_bash_limitations() {
    log_header "⚠️  Git Bash Limitations"
    
    echo "Git Bash works well for basic development, but has some limitations:"
    echo ""
    echo "✓ Works:"
    echo "  - Git workflows"
    echo "  - Bash shell scripts"
    echo "  - npm/node development"
    echo "  - Python development"
    echo "  - Text editing (vim, nano)"
    echo ""
    echo "⚠ Limited or problematic:"
    echo "  - Some shell built-ins behave differently"
    echo "  - Full Linux compatibility"
    echo "  - Docker integration"
    echo "  - Some system utilities"
    echo ""
    echo "💡 Recommendation:"
    echo "   For full compatibility, consider using WSL2 instead:"
    echo "   https://docs.microsoft.com/en-us/windows/wsl/install"
    echo ""
}

# Verify installation
verify_git_bash_setup() {
    log_header "✅ Verifying Setup"
    
    local all_good=true
    
    log_step "Checking dotfiles location..."
    if [[ -d "$DOTFILES_DIR" ]]; then
        log_info "✓ Dotfiles found at $DOTFILES_DIR"
    else
        log_error "✗ Dotfiles not found at $DOTFILES_DIR"
        all_good=false
    fi
    
    log_step "Checking shell config..."
    if [[ -f "$HOME/.bashrc" ]]; then
        if grep -q "dotfiles" "$HOME/.bashrc" 2>/dev/null; then
            log_info "✓ Dotfiles configured in ~/.bashrc"
        else
            log_warn "⚠ Dotfiles may not be configured in ~/.bashrc"
        fi
    else
        log_warn "⚠ ~/.bashrc not found"
        all_good=false
    fi
    
    log_step "Checking git configuration..."
    if git config --global user.name &>/dev/null; then
        GIT_NAME=$(git config --global user.name)
        log_info "✓ Git configured: $GIT_NAME"
    else
        log_warn "⚠ Git user.name not set"
    fi
    
    if [[ "$all_good" == "true" ]]; then
        log_info "Core setup verified!"
    fi
}

# Main execution
log_header "🪟 Windows 11 Git Bash Setup"

check_git_bash_environment
verify_git_bash_locations
setup_git_bash_shell
create_shell_configs
link_files_git_bash
setup_git_windows
create_windows_helpers
show_git_bash_limitations
verify_git_bash_setup

echo ""
log_header "✨ Git Bash Setup Complete!"
log_info "Next steps:"
echo "  1. Close and reopen Git Bash to reload configuration"
echo "  2. Test by running: git --version"
echo "  3. Configure git identity if needed:"
echo "     git config --global user.name 'Your Name'"
echo "     git config --global user.email 'your.email@example.com'"
echo "  4. Read CUSTOMIZATION_GUIDE.md to personalize your setup"
echo ""
log_warn "Note: Some features may have limited support in Git Bash."
log_warn "Consider WSL2 for full Linux-like experience on Windows."
echo ""
