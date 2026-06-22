# Custom Executables

Custom shell scripts, utilities, and tools for common developer tasks.

## Usage

Add this directory to your PATH to use scripts from anywhere:

```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
```

Or symlink individual scripts to `~/bin/` or `/usr/local/bin/`:

```bash
ln -s ~/.dotfiles/bin/git-cleanup ~/bin/git-cleanup
```

## Available Scripts

### Git Utilities

#### `git-cleanup`
Remove merged and stale local git branches to keep your repository clean.

```bash
git-cleanup --dry-run    # Preview what will be deleted
git-cleanup --force      # Actually delete merged branches
```

Features:
- Lists merged branches
- Removes stale branches (tracked as [gone])
- Preserves main/master/develop branches
- Dry-run mode by default for safety

---

### Dotfiles Management

#### `dotfiles-sync`
Sync and manage your dotfiles repository.

```bash
dotfiles-sync              # Update from GitHub
dotfiles-sync --install    # Install/link dotfiles
dotfiles-sync --check      # Show git status
```

Features:
- Pull latest dotfiles from GitHub
- Run installation script
- Check repository status
- Show recent commits

#### `dotfiles-list`
Display inventory of installed dotfiles and their status.

```bash
dotfiles-list
```

Shows:
- Which dotfiles are linked
- Which are available but not linked
- All available tool configurations
- Utility script count

---

### System Information

#### `ip-info`
Display network and IP address information.

```bash
ip-info              # Show local and public IPs
ip-info --local      # Show only local addresses
ip-info --public     # Show only public IP
ip-info --all        # Show all network info
```

Features:
- Local IP addresses on all interfaces
- Public IP address (via api.ipify.org)
- Network interface names
- Cross-platform (macOS/Linux)

#### `open-port`
Find what process is running on a specific port.

```bash
open-port 3000       # Check port 3000
open-port 8080       # Check port 8080
```

Shows:
- Process ID (PID)
- Command/process name
- Owner

---

### File Utilities

#### `find-large`
Find large files in a directory.

```bash
find-large              # Find files > 100MB in current directory
find-large 50M          # Find files > 50MB
find-large 10M /var     # Find files > 10MB in /var
```

Shows:
- Filename
- File size
- Sorted by size (largest first)

#### `mkcd`
Create a directory and change into it (shortcut).

```bash
mkcd ~/projects/my-app   # Create directory and cd into it
```

---

### System Updates

#### `update-system`
Update system packages and tools.

```bash
update-system          # Update everything (brew, npm, pip)
update-system --all    # Same as above
update-system --brew   # Update Homebrew only
update-system --npm    # Update npm packages only
update-system --pip    # Update pip packages only
```

Features:
- Updates Homebrew and packages (macOS)
- Updates global npm packages
- Upgrades pip
- Cleanup after updates

---

### Terminal Utilities

#### `colors`
Display terminal color palette for reference.

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

