# Dotfiles Repository

A comprehensive, universal dotfiles repository for bootstrapping development environments across macOS, Linux, and GitHub Codespaces. This repository provides modular configuration for shell environments, git, editors, and development tools.

**Quickly get started:** [SETUP_GUIDE.md](SETUP_GUIDE.md) | **Customize your setup:** [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)

## Quick Start

```bash
# Clone and install (macOS / Linux)
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/install.sh

# For GitHub Codespaces: Automatic setup via devcontainer.json
```

**First time?** Read [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed step-by-step instructions.

---

## What's Included

### 🐚 Shell Configuration
Complete shell setup for **Zsh**, **Bash**, and **Fish** with:
- Custom aliases for faster development (`alias g='git'`, `alias ll='ls -lah'`)
- Environment variables and exports
- Shell functions for common tasks
- Path management with `setup-path` utility

**Location:** [shell/](shell/) | **Learn more:** [shell/README.md](shell/README.md)

### 🔧 Git Configuration
Git setup that saves time and reduces errors:
- User configuration (name, email, editor)
- Global gitignore rules
- Useful git aliases
- Git hooks for automation

**Location:** [git/](git/) | **Learn more:** [git/README.md](git/README.md)

### 📝 Editor Configuration
Settings and configurations for multiple editors:
- **VSCode** — Settings, keybindings, and recommended extensions
- **Vim** — Comprehensive vim configuration
- **EditorConfig** — Cross-editor consistency
- **Language-specific configs** — Python, JavaScript, TypeScript, C#

**Location:** [editor/](editor/) | **Learn more:** [editor/README.md](editor/README.md)

### 🍎 macOS Configuration
macOS-specific setup:
- System defaults (Finder, Dock, keyboard, etc.)
- Homebrew package list
- macOS-specific development tools

**Location:** [macos/](macos/) | **Learn more:** [macos/README.md](macos/README.md)

### 🐧 Linux Configuration
Linux distribution support:
- Ubuntu/Debian packages (`apt`)
- RHEL/CentOS packages (`yum`)
- Distribution detection and automatic setup

**Location:** [linux/](linux/) | **Learn more:** [linux/README.md](linux/README.md)

### 💫 GitHub Codespaces
Automatic development environment in the cloud:
- Development container configuration
- VSCode extensions
- One-click setup—no manual installation

**Location:** [codespaces/](codespaces/) | **Learn more:** [codespaces/README.md](codespaces/README.md)

### 🔨 Custom Scripts
Utility scripts for common developer tasks:
- `git-cleanup` — Remove merged and stale branches
- `setup-path` — Add scripts to shell PATH automatically
- `dotfiles-sync` — Update dotfiles from GitHub
- `find-large` — Find large files in a directory
- `open-port` — Find and open a process using a port
- And more...

**Location:** [bin/](bin/) | **Learn more:** [bin/README.md](bin/README.md)

### 📦 Installation Scripts
Automation for bootstrapping your environment:
- `install.sh` — Main installation script with OS detection
- `detect-os.sh` — Identify your operating system
- `link-dotfiles.sh` — Create symlinks for configurations
- `update-system` — Update system packages

**Location:** [scripts/](scripts/) | **Learn more:** [scripts/README.md](scripts/README.md)

---

## Why Use Dotfiles?

### ✅ Consistency
Same configurations across all your machines. Whether you're on macOS, Linux, or Codespaces, your tools work identically.

### ⚡ Speed
Bootstrap a development environment in minutes instead of hours. Automate repetitive setup tasks.

### 🔄 Version Control
Track configuration changes in git. Easy to rollback if something breaks. Collaborate on configurations with your team.

### 🎯 Reproducibility
New team members get identical environments. Reduce "works on my machine" problems. Easy onboarding.

### 🛠️ Customization
Modular structure lets you use only what you need. Easy to fork and customize for your needs. Simple to extend with custom scripts.

---

## Installation Methods

### Method 1: Automated Setup (Recommended)
**Duration:** 5-10 minutes

```bash
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/install.sh
```

**What happens:**
1. OS detection (macOS, Linux, Codespaces)
2. Package installation (Homebrew, apt, yum)
3. Configuration file linking
4. System customization

**Why this method?**
- Fastest for new machines
- Handles all setup automatically
- Cross-platform support
- Easy to preview with `--dry-run`

---

### Method 2: Manual Setup
**Duration:** 15-20 minutes

Choose which components to install and link manually. Perfect for customizing the installation process.

**See [SETUP_GUIDE.md](SETUP_GUIDE.md#manual-setup) for detailed instructions.**

---

### Method 3: GitHub Codespaces
**Duration:** 2 minutes (automatic)

1. Open repository in Codespaces
2. Wait for container initialization
3. Everything is ready to use

**See [SETUP_GUIDE.md](SETUP_GUIDE.md#github-codespaces) for details.**

---

## Getting Started

### For First-Time Users

1. **Read [SETUP_GUIDE.md](SETUP_GUIDE.md)**
   - Step-by-step installation instructions
   - Explanation of each step
   - Troubleshooting guide
   - Post-installation verification

2. **Run the installation**
   ```bash
   git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ./scripts/install.sh --dry-run  # Preview first
   ./scripts/install.sh            # Run installation
   ```

3. **Configure git identity**
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

4. **Verify installation**
   ```bash
   echo $PATH          # Should include ~/.dotfiles/bin
   git config user.name  # Should show your name
   which git-cleanup   # Should find the script
   ```

### For Experienced Users

1. **Preview what will be installed:**
   ```bash
   ./scripts/install.sh --dry-run
   ```

2. **Run installation with options:**
   ```bash
   ./scripts/install.sh --skip-packages    # Link files only
   ./scripts/install.sh --skip-link        # Install packages only
   ```

3. **Customize for your workflow:**
   - Edit [shell/aliases.sh](shell/aliases.sh) for your aliases
   - Add functions to [shell/functions.sh](shell/functions.sh)
   - Configure git in [git/config](git/config)
   - See [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) for more

---

## Directory Structure

```
dotfiles/
├── shell/                   # Shell configuration (zsh, bash, fish)
│   ├── aliases.sh           # Command shortcuts
│   ├── exports.sh           # Environment variables
│   ├── functions.sh         # Custom shell functions
│   └── README.md            # Shell configuration guide
│
├── git/                     # Git configuration
│   ├── config               # Git settings and aliases
│   ├── ignore               # Global gitignore rules
│   └── README.md            # Git setup guide
│
├── editor/                  # Editor configurations
│   ├── vscode/              # Visual Studio Code settings
│   ├── vim/                 # Vim configuration
│   ├── javascript/          # JavaScript/TypeScript tools
│   ├── python/              # Python development tools
│   ├── typescript/          # TypeScript configuration
│   ├── TOOL_CONFIG_REFERENCE.md  # Tool configuration reference
│   └── README.md            # Editor setup guide
│
├── macos/                   # macOS-specific configuration
│   ├── defaults.sh          # macOS system defaults
│   ├── homebrew.txt         # Homebrew packages to install
│   └── README.md            # macOS guide
│
├── linux/                   # Linux-specific configuration
│   ├── apt-packages.txt     # Ubuntu/Debian packages
│   ├── yum-packages.txt     # RHEL/CentOS packages
│   └── README.md            # Linux guide
│
├── codespaces/              # GitHub Codespaces configuration
│   ├── devcontainer.json    # Container definition
│   ├── extensions.json      # VSCode extensions
│   ├── init.sh              # Setup script
│   └── README.md            # Codespaces guide
│
├── scripts/                 # Installation and utility scripts
│   ├── install.sh           # Main installation script
│   ├── detect-os.sh         # OS detection utility
│   ├── link-dotfiles.sh     # Symlink management
│   └── README.md            # Scripts guide
│
├── bin/                     # Custom executable scripts
│   ├── git-cleanup          # Remove merged branches
│   ├── setup-path           # Add bin/ to PATH
│   ├── dotfiles-sync        # Update dotfiles
│   ├── find-large           # Find large files
│   ├── open-port            # Open process by port
│   └── README.md            # Available scripts
│
├── SETUP_GUIDE.md           # Step-by-step installation guide
├── CUSTOMIZATION_GUIDE.md   # Customization and extension guide
├── README.md                # This file
└── .gitignore               # Git ignore rules
```

---

## Common Tasks

### Install and Set Up

```bash
# Quick setup
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./scripts/install.sh

# Manual setup
./scripts/install.sh --skip-packages
# Then link files manually

# Codespaces
# Opens automatically in devcontainer
```

### Add Your Own Aliases

```bash
# Edit the aliases file
vim ~/.dotfiles/shell/aliases.sh

# Add your alias
alias myproj="cd ~/projects/my-project"

# Reload shell
source ~/.zshrc
```

### Clean Up Git Branches

```bash
# Preview what will be deleted
git-cleanup --dry-run

# Actually delete merged branches
git-cleanup --force
```

### Update Dotfiles

```bash
# Sync from GitHub
dotfiles-sync

# Or manually
cd ~/.dotfiles && git pull
```

### Find and Use Custom Scripts

```bash
# List available scripts
ls ~/.dotfiles/bin/

# Get help for a script
git-cleanup --help

# Add a directory to PATH
setup-path --zsh
```

---

## Why Each Component Exists

### Shell Configuration
**Problem:** Different shells on different machines, repeated setup on each new environment
**Solution:** Centralized shell configuration that works across zsh, bash, and fish

### Git Configuration
**Problem:** Manually configuring git on every machine, forgetting settings
**Solution:** Central git config with aliases and best-practice defaults

### Editor Configuration
**Problem:** Editor settings not synchronized, inconsistent coding style
**Solution:** Shared editor configs for VSCode and Vim with language-specific rules

### macOS Configuration
**Problem:** macOS defaults aren't developer-friendly, manual customization needed
**Solution:** Script to apply sensible macOS defaults automatically

### Linux Configuration
**Problem:** Different Linux distributions have different package managers
**Solution:** Distribution-specific package lists and OS detection

### GitHub Codespaces
**Problem:** Cloud development environments need setup, wanting identical local/cloud development
**Solution:** devcontainer configuration for one-click setup with all tools pre-configured

### Custom Scripts
**Problem:** Repetitive developer tasks (branch cleanup, port searching, etc.)
**Solution:** Reusable scripts for common operations

### Installation Scripts
**Problem:** Manual setup is error-prone and time-consuming
**Solution:** Automated installation with OS detection and validation

---

## Customization

This repository is designed to be customized! Edit files directly:

- **Add personal aliases** → [shell/aliases.sh](shell/aliases.sh)
- **Define functions** → [shell/functions.sh](shell/functions.sh)
- **Set environment variables** → [shell/exports.sh](shell/exports.sh)
- **Configure git** → [git/config](git/config)
- **Add custom scripts** → [bin/](bin/)

See [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) for:
- How to customize each component
- Creating your own utility scripts
- Machine-specific configurations
- Sharing customizations with your team

---

## Features & Benefits

| Feature | Benefit | When to Use |
|---------|---------|------------|
| **Automated Installation** | Fast setup on new machines | First-time setup, new team members |
| **OS Detection** | Works identically on macOS, Linux, Codespaces | Any development environment |
| **Custom Scripts** | Reduce repetitive tasks | Daily development workflow |
| **Git Integration** | Consistent commit practices | All development |
| **Editor Configs** | Consistent coding style | Team development |
| **Version Control** | Track all configuration changes | Team collaboration, rollback if needed |
| **Modular Design** | Use only what you need | Flexible team setups |
| **Easy Customization** | Fork and modify for your needs | Org-specific configurations |

---

## Troubleshooting

### Scripts Not Found After Installation

```bash
# Verify PATH includes ~/.dotfiles/bin
echo $PATH | grep dotfiles

# If not, reload your shell
source ~/.zshrc

# Or add to shell config permanently
echo 'export PATH="$HOME/.dotfiles/bin:$PATH"' >> ~/.zshrc
```

### Installation Fails

```bash
# Preview what will happen
./scripts/install.sh --dry-run

# Check your OS is detected correctly
bash scripts/detect-os.sh

# Try skipping certain steps
./scripts/install.sh --skip-packages
```

### Permission Issues

```bash
# Make scripts executable
chmod +x ~/.dotfiles/scripts/*.sh
chmod +x ~/.dotfiles/bin/*

# Try installation again
./scripts/install.sh
```

**See [SETUP_GUIDE.md — Troubleshooting](SETUP_GUIDE.md#troubleshooting) for more help.**

---

## Contributing

Contributions are welcome! Ways to contribute:

- **Report bugs** — Open an issue with details and reproduction steps
- **Suggest features** — Ideas for new scripts or configurations
- **Share customizations** — Useful aliases, functions, or tools
- **Improve documentation** — Fixes, clarifications, or examples
- **Fix bugs** — Pull requests with tests and documentation

---

## Documentation

| Guide | Purpose |
|-------|---------|
| [SETUP_GUIDE.md](SETUP_GUIDE.md) | Step-by-step installation instructions |
| [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) | How to customize and extend |
| [shell/README.md](shell/README.md) | Shell configuration details |
| [git/README.md](git/README.md) | Git configuration details |
| [editor/README.md](editor/README.md) | Editor setup and tools |
| [bin/README.md](bin/README.md) | Custom scripts and utilities |
| [scripts/README.md](scripts/README.md) | Installation scripts reference |

---

## Supported Environments

| Environment | Status | Setup |
|-------------|--------|-------|
| **macOS** (10.15+) | ✅ Fully supported | Automatic with Homebrew |
| **Ubuntu/Debian** | ✅ Fully supported | Automatic with apt |
| **RHEL/CentOS/Fedora** | ✅ Fully supported | Automatic with yum |
| **GitHub Codespaces** | ✅ Fully supported | Automatic via devcontainer |

---

## Quick Reference

### Common Commands

```bash
# Installation and setup
./scripts/install.sh              # Full automated setup
./scripts/install.sh --dry-run    # Preview without changes

# Utility scripts
git-cleanup --dry-run             # Preview branch cleanup
setup-path                        # Add bin/ to PATH
dotfiles-sync                     # Update from GitHub

# Shell configuration
source ~/.zshrc                   # Reload shell
echo $PATH                        # Check PATH
which git-cleanup                 # Verify script location

# Git configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### File Locations

| Component | Path |
|-----------|------|
| Repository | `~/.dotfiles/` |
| Shell files | `~/.dotfiles/shell/` |
| Git config | `~/.dotfiles/git/` |
| Editor configs | `~/.dotfiles/editor/` |
| Scripts | `~/.dotfiles/bin/` |
| Installation scripts | `~/.dotfiles/scripts/` |

---

## License

This repository is provided as-is for personal and team use. Modify, fork, and share as needed.

---

## Quick Links

- 📖 **Getting Started** — [SETUP_GUIDE.md](SETUP_GUIDE.md)
- 🎨 **Customization** — [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)
- 🔧 **Scripts Reference** — [bin/README.md](bin/README.md)
- 📝 **Shell Configuration** — [shell/README.md](shell/README.md)
- 🌐 **Git Configuration** — [git/README.md](git/README.md)
- 💻 **Editor Setup** — [editor/README.md](editor/README.md)
