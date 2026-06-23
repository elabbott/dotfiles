# Quick Start Reference Card

Quick reference for common tasks. Print or bookmark this page!

## Installation (60 seconds)

```bash
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/install.sh
```

After installation, reload your shell:
```bash
source ~/.zshrc  # or ~/.bashrc
```

---

## Configure Git (Required)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## Verify Installation

```bash
echo $PATH | grep dotfiles          # ✓ Should include ~/.dotfiles/bin
which git-cleanup                    # ✓ Should find script
git config user.name                 # ✓ Should show your name
```

---

## Available Scripts

| Script | Command | What It Does |
|--------|---------|-------------|
| **Git Cleanup** | `git-cleanup --dry-run` | Preview merged branches to delete |
| **Setup PATH** | `setup-path` | Add scripts to PATH automatically |
| **Open Port** | `open-port 3000` | Find process using port 3000 |
| **Find Large Files** | `find-large 100M` | Find files larger than 100MB |
| **IP Info** | `ip-info` | Show local and public IP addresses |
| **Dotfiles Sync** | `dotfiles-sync` | Update from GitHub |

---

## Common Aliases

| Alias | Full Command |
|-------|-------------|
| `g` | `git` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gs` | `git status` |
| `ll` | `ls -lh` |
| `la` | `ls -lAh` |

---

## Customization Basics

### Add an Alias

```bash
# Edit aliases file
vim ~/.dotfiles/shell/aliases.sh

# Add your alias
alias myproj="cd ~/projects/my-project"

# Reload shell
source ~/.zshrc
```

### Add an Environment Variable

```bash
# Edit exports file
vim ~/.dotfiles/shell/exports.sh

# Add your export
export EDITOR=vim

# Reload shell
source ~/.zshrc
```

### Add a Function

```bash
# Edit functions file
vim ~/.dotfiles/shell/functions.sh

# Add your function
myfunction() {
    echo "Hello from my function"
}

# Reload shell
source ~/.zshrc
```

---

## Documentation Guide

| Looking For | Read |
|------------|------|
| **Installation help** | [SETUP_GUIDE.md](SETUP_GUIDE.md) |
| **Customization help** | [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) |
| **Troubleshooting** | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| **Shell configuration details** | [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md) |
| **Architecture/design** | [ARCHITECTURE.md](ARCHITECTURE.md) |
| **All documentation** | [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md) |

---

## Common Problems & Quick Fixes

### "Scripts not found"
```bash
source ~/.zshrc
# Or add to shell config:
export PATH="$HOME/.dotfiles/bin:$PATH"
```

### "Alias not working"
```bash
# Verify it's defined
alias myalias

# If not, check shell config sources aliases.sh:
grep aliases ~/.zshrc
```

### "Git doesn't know who I am"
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### "Installation failed"
```bash
# See what will happen first
./scripts/install.sh --dry-run

# Check your OS is detected
bash scripts/detect-os.sh

# Try without package installation
./scripts/install.sh --skip-packages
```

---

## File Locations

| What | Where |
|------|-------|
| **Repository** | `~/.dotfiles/` |
| **Aliases** | `~/.dotfiles/shell/aliases.sh` |
| **Functions** | `~/.dotfiles/shell/functions.sh` |
| **Environment vars** | `~/.dotfiles/shell/exports.sh` |
| **Custom scripts** | `~/.dotfiles/bin/` |
| **Git config** | `~/.dotfiles/git/config` |
| **Your shell config** | `~/.zshrc` or `~/.bashrc` |

---

## Installation Options

```bash
# Full installation (recommended)
./scripts/install.sh

# Preview without changes
./scripts/install.sh --dry-run

# Link files only (skip packages)
./scripts/install.sh --skip-packages

# Install packages only (skip linking)
./scripts/install.sh --skip-link
```

---

## Workflow Examples

### Starting a New Project

```bash
# Create directory and enter it
mkcd ~/projects/my-new-project

# Initialize git
git init

# Edit project files
# ...

# Commit
git add .
git commit -m "Initial commit"
```

### Cleaning Up Git Branches

```bash
# See merged branches
git-cleanup --dry-run

# Delete them
git-cleanup --force

# Verify
git branch -a
```

### Adding a Utility Script

```bash
# Create script
cat > ~/.dotfiles/bin/my-script << 'EOF'
#!/usr/bin/env bash
echo "Hello from my script"
EOF

# Make executable
chmod +x ~/.dotfiles/bin/my-script

# Use it
my-script
```

---

## Key Concepts

### Aliases
**What:** Shortcuts for commands
**Example:** `alias ll='ls -lh'`
**File:** `shell/aliases.sh`

### Functions
**What:** More powerful than aliases; can use arguments
**Example:** `mkcd() { mkdir -p "$1" && cd "$1"; }`
**File:** `shell/functions.sh`

### Exports
**What:** Environment variables for all programs
**Example:** `export EDITOR=vim`
**File:** `shell/exports.sh`

### Symlinks
**What:** Reference to file without copying
**Example:** `ln -s ~/.dotfiles/shell/aliases.sh ~/.zsh_aliases`
**Benefit:** Changes apply immediately

---

## Shell Commands Reference

```bash
# Check PATH
echo $PATH

# See all aliases
alias

# See all functions
declare -F

# Show environment variables
env | grep VARIABLE

# Reload shell config
source ~/.zshrc

# Check if file is executable
ls -la ~/.dotfiles/bin/script-name

# Find a command
which git-cleanup
```

---

## Tips & Tricks

### Search Documentation
- Use Ctrl+F in your browser to search
- Most topics have a dedicated guide

### Use Dry-Run Mode
```bash
# Always preview first for potentially destructive operations
git-cleanup --dry-run
./scripts/install.sh --dry-run
```

### Make Backup Before Editing
```bash
# Before editing important files
cp ~/.dotfiles/shell/aliases.sh ~/.dotfiles/shell/aliases.sh.backup
```

### Test Changes Safely
```bash
# Source in subshell to test
bash -c 'source ~/.dotfiles/shell/aliases.sh && ll'
```

### Check for Syntax Errors
```bash
# Before sourcing files
bash -n ~/.dotfiles/shell/aliases.sh
zsh -n ~/.zshrc
```

---

## Support Resources

- **Setup Help:** [SETUP_GUIDE.md](SETUP_GUIDE.md)
- **Customization:** [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)
- **Issues:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Shell:** [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md)
- **Scripts:** [bin/README.md](bin/README.md)
- **All Docs:** [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)

---

## Next Steps

1. ✅ **Install** — `cd ~/.dotfiles && ./scripts/install.sh`
2. ✅ **Configure Git** — `git config --global user.name "Your Name"`
3. ✅ **Test** — `which git-cleanup`
4. 📖 **Customize** — Edit `~/.dotfiles/shell/aliases.sh`
5. 🚀 **Explore** — Check [bin/README.md](bin/README.md) for more scripts

---

## Keyboard Shortcuts

```bash
# Zsh/Bash navigation
Ctrl+A          # Beginning of line
Ctrl+E          # End of line
Ctrl+R          # Search history
Ctrl+U          # Delete to beginning of line
Ctrl+K          # Delete to end of line
Ctrl+L          # Clear screen
```

---

## One-Liners

```bash
# View all git-cleanup options
git-cleanup --help

# Setup path for current shell
~/.dotfiles/bin/setup-path

# Show current PATH as lines
echo $PATH | tr ':' '\n'

# Test an alias works
bash -c 'source ~/.dotfiles/shell/aliases.sh && ll'

# Check what will be deleted
git-cleanup --dry-run

# Find your local IP
ip-info --local

# Find large files
find-large 100M ~
```

---

## Remember

- **Questions?** Check [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)
- **Problems?** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Customize?** Edit files in `~/.dotfiles/`
- **Need help?** Read the guides!

---

**Print this page or save as bookmark for quick reference!**

