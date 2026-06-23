# Custom Scripts and Utilities

Utility scripts for common developer tasks that save time and reduce errors. These scripts are designed to be cross-platform (macOS, Linux) and work with your shell of choice.

## Table of Contents

- [Setup](#setup)
- [Available Scripts](#available-scripts)
- [Why These Scripts Exist](#why-these-scripts-exist)
- [Contributing Scripts](#contributing-scripts)

---

## Setup

### Quick Start

Add these scripts to your PATH so you can use them from any directory:

#### Option 1: Automatic Setup (Recommended)

```bash
~/.dotfiles/bin/setup-path
```

This automatically detects your shell and adds the scripts to your PATH.

**Why use this?**
- One command to set everything up
- Detects your current shell automatically
- Safer than manual configuration
- Creates backup if needed

#### Option 2: Manual Setup

Add to your shell configuration file (`~/.zshrc`, `~/.bashrc`, or `~/.config/fish/config.fish`):

```bash
# For zsh/bash
export PATH="$HOME/.dotfiles/bin:$PATH"

# For fish
set -gx PATH ~/.dotfiles/bin $PATH
```

After editing, reload your shell:
```bash
source ~/.zshrc  # or ~/.bashrc
```

#### Option 3: System-wide Installation (Optional)

Symlink individual scripts to `/usr/local/bin/`:

```bash
# Link all scripts
sudo ln -s ~/.dotfiles/bin/* /usr/local/bin/

# Or link specific scripts
sudo ln -s ~/.dotfiles/bin/git-cleanup /usr/local/bin/
sudo ln -s ~/.dotfiles/bin/open-port /usr/local/bin/
```

**Why might you do this?**
- Scripts available to all users on the system
- No shell configuration needed
- Available in restricted shells

---

## Available Scripts

### Setup & Configuration

#### `setup-path`

Add the `~/.dotfiles/bin` directory to your shell's PATH automatically.

**Usage:**
```bash
setup-path                    # Auto-detect your shell
setup-path --zsh              # Setup zsh only
setup-path --bash             # Setup bash only
setup-path --fish             # Setup fish only
setup-path --all              # Setup all three shells
setup-path --dry-run          # Preview without making changes
```

**What it does:**
- Detects your current shell
- Adds `export PATH="$HOME/.dotfiles/bin:$PATH"` to your shell config
- Creates shell config files if they don't exist
- Makes backups of existing configs
- Validates changes work

**Why use this?**
- Easier than manually editing shell configs
- Less error-prone than manual edits
- Works with multiple shells
- Dry-run mode for safety
- One-time setup

**Example:**
```bash
# First time setup
~/.dotfiles/bin/setup-path

# Reload shell
source ~/.zshrc

# Verify it worked
echo $PATH | grep dotfiles
```

---

### Git Utilities

#### `git-cleanup`

Safely remove merged and stale local git branches to keep your repository clean.

**Usage:**
```bash
git-cleanup                   # Show what would be deleted (default)
git-cleanup --dry-run         # Same as above
git-cleanup --force           # Actually delete branches
git-cleanup --days 30         # Find branches not updated in 30 days
git-cleanup --force --days 7  # Delete branches stale for 7+ days
```

**What it does:**
- Lists branches that have been merged into main/master
- Finds stale branches (no recent commits)
- Deletes only local branches (doesn't affect remotes)
- Preserves important branches (main, master, develop)
- Shows a summary before and after

**Why use this?**
- Cluttered repositories are hard to work with
- Branch cleanup reduces cognitive load
- Prevents accidentally checking out old branches
- Dry-run mode prevents accidental deletions
- Time-based cleanup prevents orphaned branches

**Example workflow:**
```bash
# See what will be deleted
git-cleanup --dry-run

# Review the list
# If it looks good, delete them
git-cleanup --force

# Verify deletion
git branch -a
```

**Safety features:**
- Dry-run is the default (must use `--force` to delete)
- Preserves main/master/develop branches always
- Shows branch age and merge status
- Confirmation summary before deletion

---

#### `dotfiles-sync`

Update your dotfiles from GitHub and re-run the installation.

**Usage:**
```bash
dotfiles-sync                 # Pull latest and update links
dotfiles-sync --check         # Show git status without updating
dotfiles-sync --pull-only     # Just pull from GitHub
```

**What it does:**
- Fetches latest dotfiles from GitHub
- Updates local copies
- Re-runs the installation script to apply updates
- Shows git status and recent commits
- Reports any conflicts or issues

**Why use this?**
- Keeps your dotfiles up to date with team changes
- Applies new configurations automatically
- Updates custom scripts with latest versions
- Easier than manual git commands
- Single command for full update

**Example:**
```bash
# Check if updates available
dotfiles-sync --check

# Update to latest
dotfiles-sync

# Verify everything still works
which git-cleanup
echo $PATH
```

---

### Dotfiles Management

#### `dotfiles-list`

Display an inventory of what's installed and configured.

**Usage:**
```bash
dotfiles-list                 # Show full inventory
```

**Shows:**
- Which shell configurations are linked
- Available editor configurations
- Installed utility scripts
- Git configuration status
- Overall setup completeness

**Why use this?**
- Understand what's been set up
- Verify all components are in place
- Identify missing configurations
- Troubleshoot setup issues

---

### System Information

#### `ip-info`

Display network configuration and IP addresses.

**Usage:**
```bash
ip-info                       # Show all IP information
ip-info --local               # Show only local IPs
ip-info --public              # Show only public IP
ip-info --all                 # Same as no options
```

**Shows:**
- Local IP addresses on all network interfaces
- Public IP address (fetched from api.ipify.org)
- Network interface names and types
- Works on macOS and Linux

**Why use this?**
- Quickly find your IP when needed
- Check multiple network interfaces
- Verify network connectivity
- Useful for server configuration and debugging
- Especially useful in containers/VMs

**Example use cases:**
```bash
# SSH to this machine from another one
ip-info --local

# Setup SSH tunneling (need public IP)
ip-info --public

# Debug network issues
ip-info
```

---

#### `open-port`

Find which process is using a specific port.

**Usage:**
```bash
open-port 3000                # Check port 3000
open-port 8080                # Check port 8080
open-port 5432                # Check port 5432
```

**Shows:**
- Process ID (PID)
- Command that started the process
- Process owner (user)
- Full command line

**Why use this?**
- Troubleshoot "port already in use" errors
- Find rogue processes
- Kill processes using specific ports
- Verify expected services are running
- Quick debugging without `lsof` commands

**Example workflow:**
```bash
# Check if port 3000 is in use
open-port 3000

# Process is running - need to kill it?
# Kill the process
kill -9 <PID>

# Verify port is now free
open-port 3000  # Should show nothing
```

---

### File Utilities

#### `find-large`

Locate large files in a directory to clean up disk space.

**Usage:**
```bash
find-large                    # Find files > 100MB in current dir
find-large 50M                # Find files > 50MB
find-large 10M /var           # Find files > 10MB in /var
find-large 1G ~/Downloads     # Find files > 1GB in Downloads
```

**Shows:**
- Filename with full path
- File size in human-readable format
- Sorted by size (largest first)

**Why use this?**
- Identify disk space hogs quickly
- Clean up unnecessary large files
- Faster than using file managers
- Works recursively through directories
- Great for finding build artifacts, backups, caches

**Example use cases:**
```bash
# Find what's filling up your disk
find-large 100M ~

# Clean up old downloads
find-large 50M ~/Downloads

# Check for forgotten backups
find-large 500M ~

# Find node_modules and similar large directories
find-large 1G ~/projects
```

---

#### `mkcd`

Create a directory and immediately change into it (convenience command).

**Usage:**
```bash
mkcd ~/projects/my-app        # Create directory and cd into it
mkcd ./new-folder             # Works with relative paths too
mkcd -p ~/a/b/c/d             # Create nested directories
```

**Why use this?**
- Combines two commands into one
- Less typing for common task
- Prevents forgetting to cd after mkdir
- Works with nested paths (same as `mkdir -p`)

**Example workflow:**
```bash
# Traditional way (two commands)
mkdir -p ~/projects/new-app
cd ~/projects/new-app

# With mkcd (one command)
mkcd ~/projects/new-app
```

---

### System Updates

#### `update-system`

Update all system packages and development tools.

**Usage:**
```bash
update-system                 # Update everything
update-system --all           # Same as above
update-system --brew          # Update Homebrew packages only (macOS)
update-system --npm           # Update global npm packages only
update-system --pip           # Update Python packages only
update-system --dry-run       # Preview without updating
```

**What it does:**
- Updates Homebrew and installed packages (macOS only)
- Updates global npm packages to latest versions
- Upgrades pip and installed Python packages
- Cleans up after updates (removes old files)
- Reports what was updated
- Handles errors gracefully

**Why use this?**
- One command to update everything
- Keeps development tools current
- Security updates for dependencies
- Fewer commands to remember
- Useful for regular maintenance

**Example maintenance workflow:**
```bash
# Check what would be updated
update-system --dry-run

# Do actual update
update-system

# Verify everything still works
npm --version
python --version
```

**Why each component?**
- **Homebrew** — Installed system tools and languages
- **npm** — Global JavaScript/Node tools
- **pip** — Global Python tools

---

### Terminal Utilities

#### `colors`

Display terminal color palette reference.

**Usage:**
```bash
colors                        # Display color palette
```

**Shows:**
- All 256 ANSI color codes
- Color names and numbers
- Preview of each color
- Useful for shell prompt customization

**Why use this?**
- Reference when customizing shell prompts
- Test color support in your terminal
- Choose colors for scripts and messages
- Quick reference without searching online

---

## Why These Scripts Exist

Each script solves a real development problem:

| Script | Problem It Solves | Benefit |
|--------|------------------|---------|
| `setup-path` | Manual shell config is error-prone | Automated safe setup |
| `git-cleanup` | Cluttered branches slow you down | Clean git history |
| `dotfiles-sync` | Need to remember git commands | One-command update |
| `open-port` | Hard to find processes on ports | Quick debugging |
| `find-large` | Disk space issues hard to diagnose | Identify problem files |
| `mkcd` | Two commands for one task | Faster workflow |
| `update-system` | Multiple commands to update tools | Single update command |
| `ip-info` | Need multiple tools for IP info | Quick network check |
| `colors` | Hard to remember color codes | Visual reference |

---

## Contributing Scripts

Want to add your own scripts? Here's how:

### Creating a New Script

1. **Create the script file** in this directory
2. **Make it executable**: `chmod +x my-script`
3. **Add usage documentation** at the top
4. **Test thoroughly** across macOS and Linux
5. **Document in this README**

### Script Template

```bash
#!/usr/bin/env bash
# my-script: Brief description
# Usage: my-script [options]
# Description of what this script does.

set -e

# Help message
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    echo "Usage: my-script [options]"
    echo ""
    echo "Description of what this script does"
    echo ""
    echo "Options:"
    echo "  --option1    Description"
    echo "  --option2    Description"
    exit 0
fi

# Main script logic here
echo "Script logic"
```

### Best Practices

- **Portable:** Works on macOS and Linux
- **Safe:** Use `set -e` and validate inputs
- **Clear:** Good comments and error messages
- **Documented:** Help text and examples
- **Tested:** Works in different scenarios
- **Minimal:** Solves one problem well

---

## Troubleshooting

### Scripts Not Found

```bash
# Verify PATH includes the directory
echo $PATH | grep dotfiles

# If not there, re-run setup
~/.dotfiles/bin/setup-path

# Reload shell
source ~/.zshrc
```

### Permission Denied

```bash
# Make scripts executable
chmod +x ~/.dotfiles/bin/*

# Try again
git-cleanup --help
```

### Script Errors

```bash
# Run with debugging
bash -x ~/.dotfiles/bin/my-script

# Check for errors
bash -n ~/.dotfiles/bin/my-script
```

---

## More Information

- **Installation:** See [SETUP_GUIDE.md](../SETUP_GUIDE.md)
- **Customization:** See [CUSTOMIZATION_GUIDE.md](../CUSTOMIZATION_GUIDE.md)
- **Main README:** See [README.md](../README.md)

```bash
colors
```

Shows:
- Standard 8 colors
- Bright 8 colors
- Full 256-color palette
- Example color codes for scripts

---

## Writing Your Own Scripts

All scripts follow these conventions:

1. **Shebang**: `#!/usr/bin/env bash`
2. **Error handling**: `set -e` for exit on error
3. **Documentation**: Comments at top with usage
4. **Color output**: Use common color codes
5. **Help text**: Show usage for --help or errors
6. **Cross-platform**: Support macOS and Linux when possible

### Template

```bash
#!/usr/bin/env bash
# script-name: Brief description
# Usage: script-name [options]

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function
main() {
    echo "Doing something..."
    echo -e "${GREEN}✅ Success${NC}"
}

main "$@"
```

## Adding Scripts to Your Path

### Temporary
```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
```

### Permanent (add to ~/.zshrc or ~/.bashrc)
```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
```

### Symlink
```bash
mkdir -p ~/bin
ln -s ~/.dotfiles/bin/* ~/bin/
```

## Tips

- All scripts have `--help` or usage in comments
- Use `colors` to reference color codes in your scripts
- Check `dotfiles-list` to see what's installed
- Use `dotfiles-sync` to keep scripts up to date

