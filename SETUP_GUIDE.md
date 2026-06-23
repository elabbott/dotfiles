# Dotfiles Setup Guide

A comprehensive step-by-step guide to install and configure your development environment using this dotfiles repository.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Methods](#installation-methods)
  - [Quick Start (Recommended)](#quick-start-recommended)
  - [Manual Setup](#manual-setup)
  - [GitHub Codespaces](#github-codespaces)
  - [Windows 11](#windows-11)
- [Post-Installation Setup](#post-installation-setup)
- [Verifying Installation](#verifying-installation)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before you begin, ensure you have:

1. **Git** — Version 2.30 or later
   ```bash
   git --version
   ```
   If not installed:
   - **macOS**: `brew install git`
   - **Linux (Ubuntu/Debian)**: `sudo apt-get install git`
   - **Linux (RHEL/CentOS)**: `sudo yum install git`
   - **Windows 11**: Install [Git for Windows](https://git-scm.com/download/win) or enable WSL2

2. **A supported shell**:
   - Zsh (preferred for macOS)
   - Bash (compatible with all systems, required for Windows)
   - Fish (supported for PATH setup)
   - **Windows 11**: Use WSL2 for Zsh/Bash, or Git Bash

3. **Administrator/sudo access** (required for system package installation)

4. **For Windows 11**: One of:
   - WSL2 enabled (recommended)
   - Git Bash installed
   - Chocolatey or Scoop package manager

---

## Installation Methods

### Quick Start (Recommended)

**Duration**: 5-10 minutes

The automated installation script handles everything: OS detection, package installation, and dotfile linking.

#### Step 1: Clone the repository

```bash
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

**Why this location?**
- `~/.dotfiles` is the standard convention for dotfiles repositories
- All scripts assume this location for symlinks
- Easy to backup and version control

#### Step 2: Preview changes (optional but recommended)

```bash
./scripts/install.sh --dry-run
```

**What this does:**
- Shows exactly what will be installed
- Does NOT make any changes to your system
- Helps you understand what the script will do
- No risk—safe to run at any time

**Review the output for:**
- Which packages will be installed
- Which symlinks will be created
- Whether any conflicts exist

#### Step 3: Run the installation script

```bash
./scripts/install.sh
```

**What happens automatically:**
1. **OS Detection** — Identifies your operating system (macOS, Linux, Codespaces)
2. **Package Installation** — Installs development tools using:
   - Homebrew (macOS)
   - apt (Ubuntu/Debian)
   - yum (RHEL/CentOS)
3. **Dotfile Linking** — Creates symlinks for:
   - Shell configurations (`.zshrc`, `.bashrc`)
   - Git configuration
   - Editor settings (vim, VSCode)
4. **System Configuration** — Applies OS-specific defaults

#### Step 4: Reload your shell

```bash
source ~/.zshrc    # If using Zsh
source ~/.bashrc   # If using Bash
```

Or simply close and reopen your terminal.

#### Step 5: Verify installation

```bash
echo $PATH          # Should include ~/.dotfiles/bin
which git-cleanup   # Should find the script
git config user.name  # Should show your git config
```

---

### Installation with Options

Skip certain steps if you don't want them:

#### Skip package installation (keep existing packages)

```bash
./scripts/install.sh --skip-packages
```

**Use this when:**
- You've already installed packages manually
- You want to preserve your current package versions
- You're running on a system without package manager access

#### Skip dotfile linking (setup packages only)

```bash
./scripts/install.sh --skip-link
```

**Use this when:**
- You want to install system packages but link files manually later
- You need to test package installation separately
- You're customizing the linking process

#### Combine options

```bash
./scripts/install.sh --dry-run --skip-packages
./scripts/install.sh --skip-link --skip-packages
```

---

### Manual Setup

**Duration**: 15-20 minutes

For granular control or systems where the automatic script doesn't work, set up components individually.

#### Step 1: Clone the repository

```bash
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

#### Step 2: Install packages manually

##### On macOS

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages from the list
while IFS= read -r package; do
    [[ "$package" =~ ^# ]] && continue  # Skip comments
    [[ -z "$package" ]] && continue      # Skip empty lines
    brew install "$package"
done < ~/.dotfiles/macos/homebrew.txt

# Apply macOS defaults
bash ~/.dotfiles/macos/defaults.sh
```

**Why apply defaults?**
- Optimizes Finder, Dock, and system settings for development
- Improves productivity with sensible macOS configurations
- Can be customized or reverted in `macos/defaults.sh`

##### On Linux (Ubuntu/Debian)

```bash
# Update package lists
sudo apt-get update

# Install packages from the list
while IFS= read -r package; do
    [[ "$package" =~ ^# ]] && continue
    [[ -z "$package" ]] && continue
    sudo apt-get install -y "$package"
done < ~/.dotfiles/linux/apt-packages.txt
```

##### On Linux (RHEL/CentOS/Fedora)

```bash
# Update package lists
sudo yum update -y

# Install packages from the list
while IFS= read -r package; do
    [[ "$package" =~ ^# ]] && continue
    [[ -z "$package" ]] && continue
    sudo yum install -y "$package"
done < ~/.dotfiles/linux/yum-packages.txt
```

#### Step 3: Link configuration files

##### Link shell configuration

```bash
# Zsh
ln -s ~/.dotfiles/shell/aliases.sh ~/.zsh_aliases
ln -s ~/.dotfiles/shell/exports.sh ~/.zsh_exports
ln -s ~/.dotfiles/shell/functions.sh ~/.zsh_functions

# Bash
ln -s ~/.dotfiles/shell/aliases.sh ~/.bash_aliases
ln -s ~/.dotfiles/shell/exports.sh ~/.bash_exports
ln -s ~/.dotfiles/shell/functions.sh ~/.bash_functions

# Then add this to your ~/.zshrc or ~/.bashrc:
# source ~/.dotfiles/shell/aliases.sh
# source ~/.dotfiles/shell/exports.sh
# source ~/.dotfiles/shell/functions.sh
```

##### Link git configuration

```bash
# Create git config directory if it doesn't exist
mkdir -p ~/.config/git

# Link git configuration
ln -s ~/.dotfiles/git/config ~/.config/git/config
ln -s ~/.dotfiles/git/ignore ~/.gitignore_global

# Configure git to use the global ignore file
git config --global core.excludesfile ~/.gitignore_global
```

##### Link editor configurations

For Vim:
```bash
mkdir -p ~/.vim
ln -s ~/.dotfiles/editor/vim/init.vim ~/.vim/init.vim
```

For VSCode settings (if on macOS):
```bash
mkdir -p ~/Library/Application\ Support/Code/User
ln -s ~/.dotfiles/editor/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.dotfiles/editor/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
```

For VSCode settings (if on Linux):
```bash
mkdir -p ~/.config/Code/User
ln -s ~/.dotfiles/editor/vscode/settings.json ~/.config/Code/User/settings.json
ln -s ~/.dotfiles/editor/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

#### Step 4: Add scripts to PATH

```bash
# Add to ~/.zshrc or ~/.bashrc
export PATH="$HOME/.dotfiles/bin:$PATH"
```

Or use the automated helper:
```bash
~/.dotfiles/bin/setup-path
```

#### Step 5: Reload your shell

```bash
source ~/.zshrc  # or ~/.bashrc
```

---

### GitHub Codespaces

**Duration**: 2 minutes (automatic)

Codespaces automatically configures everything via `devcontainer.json`.

#### Option 1: Automatic setup

1. Open the repository in Codespaces:
   - Click "Code" → "Codespaces" → "Create codespace on main"
   - Or use the GitHub web interface

2. Wait for initialization:
   - The devcontainer initializes automatically
   - `codespaces/init.sh` runs during container setup
   - All dependencies and tools install automatically
   - VSCode extensions load automatically

3. Verify setup:
   ```bash
   echo $PATH          # Should include ~/.dotfiles/bin
   which git-cleanup   # Should find the script
   git config --list   # Should show configuration
   ```

#### Option 2: Manual Codespaces setup

```bash
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash ./codespaces/init.sh
```

**What Codespaces provides:**
- Pre-configured development environment
- No package installation required
- All tools and extensions pre-installed
- Identical setup across all Codespaces instances

---

### Windows 11

**Duration**: 10-15 minutes

Windows 11 requires special setup due to its different architecture. We recommend using WSL2 (Windows Subsystem for Linux) for the best experience, but direct Windows setup is also possible.

#### Option 1: Recommended - WSL2 Setup

WSL2 provides a full Linux environment within Windows, making this repository work seamlessly.

##### Step 1: Enable WSL2

1. **Open PowerShell as Administrator** (Win+X, then A)

2. **Enable WSL and Windows Virtualization**:
   ```powershell
   wsl --install
   ```

   **What this does:**
   - Enables Windows Subsystem for Linux
   - Downloads Ubuntu LTS by default
   - Enables required Windows features
   - May require a restart

3. **After restart, set WSL default to version 2**:
   ```powershell
   wsl --set-default-version 2
   ```

4. **Install a Linux distribution** (if not done automatically):
   ```powershell
   wsl --list --online              # See available distributions
   wsl --install -d Ubuntu-22.04    # Install specific version
   ```

**Why WSL2?**
- Full Linux kernel support
- Native bash/zsh/fish shells
- Seamless file system access
- Docker integration
- Repository works exactly as documented
- Better performance than WSL1

##### Step 2: Open WSL Terminal

1. **Open Windows Terminal** (search in Start menu) or press `Win+X` then select "Terminal"
2. **Click dropdown arrow** → Select your Linux distribution (Ubuntu, Debian, etc.)
3. **You're now in a Linux terminal**

All remaining steps are identical to Linux installation:

```bash
# In WSL2 terminal
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/install.sh --dry-run
./scripts/install.sh
```

##### Step 3: Configure Windows Terminal (Optional)

For a better experience, customize Windows Terminal settings:

1. **Open Windows Terminal**
2. **Click Settings** (Ctrl+,)
3. **Recommended settings**:
   ```json
   {
     "defaultProfile": "Ubuntu",
     "confirmCloseAllTabs": false,
     "copyOnSelect": true,
     "fontSize": 10,
     "fontFace": "Cascadia Code"
   }
   ```

4. **Set Ubuntu as default shell**:
   - Go to Settings → Defaults
   - Select your distribution under "Default profile"

**Why customize?**
- Makes terminal more productive
- Better integration with dotfiles
- Improved copy/paste experience
- Consistent with Linux terminal behavior

---

#### Option 2: Direct Windows Setup (Git Bash)

For Windows-only setup without virtualization (more limited functionality).

##### Step 1: Install Git for Windows

1. **Download from**: https://git-scm.com/download/win
2. **Run installer** with default options
3. **During installation**, ensure:
   - "Git Bash Here" is selected
   - "Add Git to PATH" is selected
   - Line ending conversion is "Checkout as-is, commit as-is"

##### Step 2: Install Node.js and npm (if needed)

```powershell
# Using Chocolatey (if installed)
choco install nodejs

# Or download from https://nodejs.org/
```

##### Step 3: Clone the Repository

1. **Open Git Bash** (right-click → "Git Bash Here" or search for "Git Bash")
2. **Navigate to home directory**:
   ```bash
   cd ~
   ```

3. **Clone the repository**:
   ```bash
   git clone https://github.com/elabbott/dotfiles.git .dotfiles
   cd .dotfiles
   ```

**Note**: Use `.dotfiles` (Windows style) instead of `~/.dotfiles`

##### Step 4: Manual Setup (Script won't work on Windows)

The installation script doesn't support Windows directly. Set up manually:

```bash
# In Git Bash

# Add bin directory to PATH
echo 'export PATH="$HOME/.dotfiles/bin:$PATH"' >> ~/.bashrc

# Source shell configuration
echo 'source ~/.dotfiles/shell/aliases.sh' >> ~/.bashrc
echo 'source ~/.dotfiles/shell/exports.sh' >> ~/.bashrc
echo 'source ~/.dotfiles/shell/functions.sh' >> ~/.bashrc

# Reload shell
source ~/.bashrc
```

##### Step 5: Create Symlinks (Manual)

```bash
# Shell aliases and functions
ln -s ~/.dotfiles/shell/aliases.sh ~/.bash_aliases
ln -s ~/.dotfiles/shell/functions.sh ~/.bash_functions

# Git configuration
mkdir -p ~/.config/git
ln -s ~/.dotfiles/git/config ~/.config/git/config

# VSCode configuration (Windows path)
mkdir -p ~/AppData/Roaming/Code/User
ln -s ~/.dotfiles/editor/vscode/settings.json ~/AppData/Roaming/Code/User/settings.json
```

**Limitations of Git Bash:**
- Some shell features may not work
- Path handling is different
- No access to WSL2 performance benefits
- Limited scripting capabilities
- Some tools may not be available

---

#### Option 3: Using Package Managers

Alternatively, use Chocolatey or Scoop to install development tools.

##### Using Chocolatey

1. **Install Chocolatey** (if not already installed):
   ```powershell
   # Run PowerShell as Administrator
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. **Install tools**:
   ```powershell
   choco install git vim nodejs python3
   ```

3. **Then follow Git Bash setup above**

##### Using Scoop

1. **Install Scoop** (if not already installed):
   ```powershell
   # Run PowerShell
   iwr -useb get.scoop.sh | iex
   ```

2. **Install tools**:
   ```powershell
   scoop install git vim nodejs python3
   ```

3. **Then follow Git Bash setup above**

**Chocolatey vs Scoop:**
- Chocolatey: Larger package selection, system-wide
- Scoop: Lighter weight, user-only installation

---

## Recommendation for Windows 11

| Scenario | Recommendation | Why |
|----------|---|---|
| **Development work** | WSL2 | Full Linux environment, works as documented |
| **Full compatibility** | WSL2 | All scripts and tools work perfectly |
| **Simple setup** | WSL2 | Faster than alternatives, modern approach |
| **No virtualization** | Git Bash | Works without Hyper-V, but limited features |
| **Quick start** | WSL2 | Most popular modern approach |

**Our recommendation**: Use WSL2. It provides the best experience and makes your Windows setup identical to Linux/macOS.

---

## Post-Installation Setup

After running the installation script, complete these optional but recommended steps:

### 1. Configure Git Identity

```bash
# Set your name (required for commits)
git config --global user.name "Your Name"

# Set your email (required for commits)
git config --global user.email "your.email@example.com"

# Optional: Set your preferred editor
git config --global core.editor "vim"  # or "nano", "code", etc.
```

**Why this matters:**
- Git needs your identity for every commit
- Commits without proper configuration show "Unknown" author
- This is the most common first-time git setup step

### 2. Generate SSH keys for GitHub

```bash
# Generate a new SSH key (if you don't have one)
ssh-keygen -t ed25519 -C "your.email@example.com"

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add your key to the agent
ssh-add ~/.ssh/id_ed25519

# Display your public key
cat ~/.ssh/id_ed25519.pub
```

**Next steps:**
1. Copy the public key output
2. Go to GitHub Settings → SSH and GPG keys
3. Click "New SSH key" and paste
4. Test connection: `ssh -T git@github.com`

**Why SSH?**
- Secure authentication without storing passwords
- Works with password managers
- Required for some advanced git operations

### 3. Customize Shell Aliases

Edit the shell configuration files to add your personal aliases:

```bash
# Open in your editor
vim ~/.dotfiles/shell/aliases.sh    # or VSCode, nano, etc.
```

Add your custom aliases:
```bash
# Example: Development shortcuts
alias proj="cd ~/projects"
alias work="cd ~/work"
alias code="code ."
alias dev="npm run dev"
```

After saving, reload your shell:
```bash
source ~/.zshrc
```

**Why customize?**
- Aliases reduce typing for frequently used commands
- Makes your workflow more efficient
- Shared across all your machines

### 4. Test Custom Scripts

```bash
# List available scripts
ls -la ~/.dotfiles/bin/

# Test a script
git-cleanup --dry-run

# Check if scripts are in your PATH
which git-cleanup
which dotfiles-sync
```

---

## Verifying Installation

Run this verification checklist to ensure everything is set up correctly:

### Shell Configuration

```bash
# Check if shell is sourcing dotfiles
echo $PATH | grep dotfiles

# Expected output: /Users/your-name/.dotfiles/bin (or similar)
```

**If this fails:** Make sure you've sourced your shell config (`source ~/.zshrc`)

### Git Configuration

```bash
# Verify git identity is set
git config --global user.name
git config --global user.email

# Verify git ignore file
git config --global core.excludesfile
```

**If this fails:** Run `git config --global user.name "Your Name"` and `git config --global user.email "your.email@example.com"`

### Custom Scripts in PATH

```bash
# Check if custom scripts are accessible
which setup-path
which git-cleanup
which dotfiles-sync

# Test a script
setup-path --help
git-cleanup --help
```

**If this fails:** Add `export PATH="$HOME/.dotfiles/bin:$PATH"` to your shell config

### Symlinks are Created

```bash
# Check if symlinks were created
ls -la ~/ | grep dotfiles

# Verify specific symlinks
ls -la ~/.config/git/config
ls -la ~/.zsh_aliases
```

**If this fails:** Run `./scripts/install.sh` again to create missing symlinks

### Full System Verification Script

```bash
#!/bin/bash
echo "=== Dotfiles Installation Verification ==="
echo ""

echo "1. Repository location:"
[ -d ~/.dotfiles ] && echo "✓ ~/.dotfiles exists" || echo "✗ ~/.dotfiles not found"

echo ""
echo "2. PATH setup:"
echo $PATH | grep -q dotfiles && echo "✓ ~/.dotfiles/bin in PATH" || echo "✗ ~/.dotfiles/bin not in PATH"

echo ""
echo "3. Git configuration:"
[ -n "$(git config --global user.name)" ] && echo "✓ Git user.name set" || echo "✗ Git user.name not set"
[ -n "$(git config --global user.email)" ] && echo "✓ Git user.email set" || echo "✗ Git user.email not set"

echo ""
echo "4. Shell configuration:"
for script in aliases exports functions; do
    [ -f ~/.dotfiles/shell/$script.sh ] && echo "✓ shell/$script.sh exists" || echo "✗ shell/$script.sh not found"
done

echo ""
echo "5. Custom scripts:"
for script in setup-path git-cleanup dotfiles-sync; do
    command -v $script &> /dev/null && echo "✓ $script available" || echo "✗ $script not available"
done
```

---

## Troubleshooting

### Issue: Permission Denied

**Error**: `permission denied: ./scripts/install.sh`

**Solution**:
```bash
# Make scripts executable
chmod +x ~/.dotfiles/scripts/*.sh
chmod +x ~/.dotfiles/bin/*

# Then run again
./scripts/install.sh
```

**Why this happens:**
- File permissions aren't preserved in some git configurations
- Git may not mark shell scripts as executable by default

### Issue: Package Installation Fails

**Error**: `apt: command not found` or similar

**Solution**:
```bash
# Check if you're on the right OS
uname -s                    # Shows OS
cat /etc/os-release | grep ID  # Shows Linux distro

# Install manually if needed
sudo apt-get install git    # For Ubuntu/Debian
sudo yum install git        # For RHEL/CentOS
```

**Why this happens:**
- Wrong package manager for your OS
- Package lists might be out of date
- Some packages might not be available in your distribution

### Issue: Symlinks Fail to Create

**Error**: `File exists` or `Permission denied`

**Solution**:
```bash
# Check what's currently at the path
ls -la ~/.zshrc

# Remove the existing file if it's a regular file (backup first)
cp ~/.zshrc ~/.zshrc.backup
rm ~/.zshrc

# Then create the symlink
ln -s ~/.dotfiles/shell/aliases.sh ~/.zsh_aliases
```

**Why this happens:**
- Configuration file already exists
- Insufficient permissions
- Conflicting symlinks

### Issue: Scripts Not Found After Installation

**Error**: `command not found: git-cleanup`

**Solution**:
```bash
# Verify PATH includes the bin directory
echo $PATH | grep dotfiles

# If not, add to your shell configuration
echo 'export PATH="$HOME/.dotfiles/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Then verify
which git-cleanup
```

**Why this happens:**
- Shell hasn't been reloaded after setup
- PATH not properly configured
- Using a different shell than expected

### Issue: Git Configuration Not Applied

**Error**: Git not recognizing configuration

**Solution**:
```bash
# Verify symlink exists
ls -la ~/.config/git/config

# Check if git is reading from the right location
git config --global core.excludesfile

# Manually set if needed
git config --global core.excludesfile ~/.gitignore_global
```

**Why this happens:**
- Git looking in a different config location
- Symlink path incorrect
- Git version difference

### Windows 11 Specific Issues

**Issue: WSL2 not working**

**Error**: `The Windows Subsystem for Linux has not been installed` or `Invalid distribution`

**Solution**:
```powershell
# Check if WSL2 is enabled
wsl --status

# If not, enable it
wsl --install

# Set WSL2 as default
wsl --set-default-version 2

# Install a distribution
wsl --list --online
wsl --install -d Ubuntu-22.04

# Restart your computer
```

**Why this happens:**
- Windows Subsystem for Linux not enabled
- Virtualization not enabled in BIOS
- Hyper-V not installed
- Windows version too old (need 19041 or later)

**Issue: Symlinks fail in WSL2**

**Error**: `Read-only file system` or symlink creation fails

**Solution**:
```bash
# Check file system type
df -T

# If using /mnt/, try copying to home directory instead
cd ~
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles

# WSL home directory symlinks should work
ln -s ~/.dotfiles/shell/aliases.sh ~/.bash_aliases
```

**Why this happens:**
- Using /mnt/ (Windows file system) has limited symlink support
- Need to use WSL2 home directory for full support

**Issue: Git Bash scripts don't work**

**Error**: Commands not found or path issues

**Solution**:
```bash
# Git Bash uses Windows paths, add to path properly
echo 'export PATH="$HOME/.dotfiles/bin:$PATH"' >> ~/.bashrc

# Not all scripts work in Git Bash (Windows limitation)
# Use WSL2 for full compatibility
```

**Why this happens:**
- Git Bash is MSYS2-based, not full Linux
- Some shell features don't translate
- Path handling is fundamentally different

---

### Still Having Issues?

1. **Check the logs**: The installation script outputs detailed information
   ```bash
   ./scripts/install.sh 2>&1 | tee install.log
   ```

2. **Run in dry-run mode first**:
   ```bash
   ./scripts/install.sh --dry-run
   ```

3. **Verify prerequisites**:
   ```bash
   git --version
   bash --version
   # or zsh --version if using Zsh
   ```

4. **Check OS detection**:
   ```bash
   bash ~/.dotfiles/scripts/detect-os.sh
   ```

5. **For Windows 11 issues**:
   ```powershell
   # Check WSL2 status
   wsl --status
   
   # List installed distributions
   wsl --list --verbose
   
   # Check version
   wsl --version
   ```

6. **Open an issue** on GitHub with:
   - Your operating system (output of `uname -s` or `[System.Environment]::OSVersion` on Windows)
   - Your shell (output of `echo $SHELL` or `$PROFILE` on Windows)
   - Error messages (full output preferred)
   - Steps to reproduce

---

## Next Steps

After successful installation:

1. **Read [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)** — Learn how to customize configurations
2. **Explore [editor/README.md](editor/README.md)** — Set up editor-specific tools
3. **Check [bin/README.md](bin/README.md)** — Learn about available utility scripts
4. **Review [shell/README.md](shell/README.md)** — Understand shell configuration options

---

## Quick Reference

### Common Commands

```bash
# Installation
./scripts/install.sh              # Full automated setup (macOS/Linux/Codespaces)
./scripts/install.sh --dry-run    # Preview without changes
./scripts/install.sh --skip-packages # Link files only

# Windows 11 (WSL2)
# Same as Linux commands above

# Windows 11 (Git Bash)
cd ~/.dotfiles
source ~/.bashrc                  # Reload configuration

# Maintenance (all platforms)
dotfiles-sync                     # Update dotfiles from GitHub
git-cleanup --dry-run            # Preview branch cleanup
git-cleanup --force              # Remove merged branches

# Shell configuration
setup-path                        # Add bin/ to PATH
source ~/.zshrc                   # Reload shell config (macOS/Linux/WSL2)
source ~/.bashrc                  # Reload shell config (Git Bash)

# Verification (all platforms)
echo $PATH                        # Check PATH includes ~/.dotfiles/bin
which git-cleanup                 # Verify script is accessible
git config --global user.name     # Check git identity
```

### File Locations

| Component | Location |
|-----------|----------|
| Repository | `~/.dotfiles/` |
| Shell config | `~/.dotfiles/shell/` |
| Git config | `~/.dotfiles/git/` |
| Editor configs | `~/.dotfiles/editor/` |
| Custom scripts | `~/.dotfiles/bin/` |
| Installation scripts | `~/.dotfiles/scripts/` |

