# Dotfiles Customization Guide

Learn how to customize and extend this dotfiles repository to match your personal workflow and preferences.

## Table of Contents

- [Quick Customizations](#quick-customizations)
- [Shell Configuration](#shell-configuration)
- [Git Configuration](#git-configuration)
- [Editor Configuration](#editor-configuration)
- [Custom Scripts](#custom-scripts)
- [OS-Specific Customization](#os-specific-customization)
- [Advanced Configuration](#advanced-configuration)
- [Sharing Your Customizations](#sharing-your-customizations)

---

## Quick Customizations

These are the easiest customizations—no scripting knowledge required.

### Add Your Personal Aliases

**File**: [shell/aliases.sh](shell/aliases.sh)

```bash
# Open the file
vim ~/.dotfiles/shell/aliases.sh

# Add your personal aliases at the end
alias myproj="cd ~/path/to/my/project"
alias build="npm run build"
alias test="npm run test"
alias deploy="npm run deploy"
```

**Why customize aliases?**
- Reduce typing for frequently used commands
- Make your workflow faster and more consistent
- Share common workflows across machines

**After editing**:
```bash
source ~/.zshrc  # Reload shell configuration
alias myproj     # Test your new alias
```

**Tips**:
- Use short, memorable names (e.g., `d` for `docker`, `k` for `kubectl`)
- Group related aliases with comments
- Document complex aliases with their purpose

---

### Define Custom Environment Variables

**File**: [shell/exports.sh](shell/exports.sh)

```bash
# Open the file
vim ~/.dotfiles/shell/exports.sh

# Add your variables
export EDITOR="vim"              # Default editor
export VISUAL="code"             # Visual editor
export LC_ALL="en_US.UTF-8"      # Language/locale
export LANG="en_US.UTF-8"

# Project-specific paths
export PROJECTS_HOME="$HOME/projects"
export WORK_HOME="$HOME/work"

# Custom tool settings
export RUST_BACKTRACE=1          # Rust error verbosity
export PYTHONUNBUFFERED=1        # Python output buffering
```

**Why use environment variables?**
- Configure tool behavior across all sessions
- Set paths used by many scripts
- Make configuration centralized and easy to change
- Portable across different machines

**Common variables to set**:
- `EDITOR` — Your default text editor
- `VISUAL` — Your visual editor (often the same as EDITOR)
- `PAGER` — Your preferred pager (less, more, bat)
- `SHELL` — Your preferred shell
- `PATH` — Additional directories to search for executables

---

### Add Shell Functions

**File**: [shell/functions.sh](shell/functions.sh)

```bash
# Open the file
vim ~/.dotfiles/shell/functions.sh

# Add your custom functions
# Function to create and navigate to a new directory
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Function to extract archive files
extract() {
    case $1 in
        *.tar.bz2)   tar xjf "$1"   ;;
        *.tar.gz)    tar xzf "$1"   ;;
        *.bz2)       bunzip2 "$1"   ;;
        *.rar)       unrar x "$1"   ;;
        *.gz)        gunzip "$1"    ;;
        *.tar)       tar xf "$1"    ;;
        *.tbz2)      tar xjf "$1"   ;;
        *.tgz)       tar xzf "$1"   ;;
        *.zip)       unzip "$1"     ;;
        *.Z)         uncompress "$1";;
        *.7z)        7z x "$1"      ;;
    esac
}

# Function to search for a process
psgrep() {
    ps aux | grep -i "$1" | grep -v grep
}
```

**Why use functions?**
- Encapsulate complex logic in reusable commands
- More powerful than aliases (can accept arguments and use logic)
- Organize your workflow into single commands
- Share frequently used operations

**Tips**:
- Use descriptive names
- Add comments explaining what the function does
- Test locally before adding to version control
- Use `$1`, `$2` for arguments; `"$@"` for all arguments

---

### Customize Git Configuration

**File**: [git/config](git/config)

```bash
# Open the file
vim ~/.dotfiles/git/config

# Add your personal git settings
[user]
    name = Your Name
    email = your.email@example.com

[core]
    editor = vim

[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --graph --oneline --all
```

**Common git customizations**:

```bash
# Set default branch name
git config --global init.defaultBranch main

# Set merge strategy
git config --global pull.rebase false

# Enable credential caching
git config --global credential.helper cache

# Set line ending handling
git config --global core.autocrlf input  # macOS/Linux
git config --global core.autocrlf true   # Windows
```

**Why customize git config?**
- Enforce consistent commit authorship
- Set up convenient aliases for common operations
- Configure merge/rebase behavior
- Handle line endings properly across platforms

---

## Shell Configuration

Learn how to extend and modify shell behavior.

### Understanding the Shell Configuration Stack

Shell files are sourced in this order:

1. **System-wide config** (e.g., `/etc/bash.bashrc`)
2. **Interactive login shell** (e.g., `~/.zshrc`, `~/.bash_profile`)
3. **Dotfiles** (e.g., `~/.dotfiles/shell/aliases.sh`)

### How Dotfiles Configure Shells

The dotfiles provide modular configuration files that are sourced by your shell:

```bash
# ~/.zshrc (managed by you or your shell)
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/exports.sh
source ~/.dotfiles/shell/functions.sh
```

### Add Zsh-Specific Configuration

**File**: Create `~/.zshrc` if it doesn't exist

```bash
# ~/.zshrc - Zsh-specific configuration

# Source dotfiles configurations
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/exports.sh
source ~/.dotfiles/shell/functions.sh

# Zsh-specific options
setopt HIST_IGNORE_DUPS          # Ignore duplicate history entries
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt SHARE_HISTORY             # Share history between terminals
setopt AUTO_CD                   # Directory change without 'cd'

# Add completions
autoload -Uz compinit && compinit

# Configure prompt (if not using a prompt framework)
PROMPT='%n@%m:%~%# '
```

### Add Bash-Specific Configuration

**File**: Create `~/.bashrc` if it doesn't exist

```bash
# ~/.bashrc - Bash-specific configuration

# Source dotfiles configurations
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/exports.sh
source ~/.dotfiles/shell/functions.sh

# Bash-specific options
shopt -s histappend              # Append to history instead of overwriting
shopt -s checkwinsize            # Check window size after each command
HISTSIZE=1000                    # Number of commands to keep
HISTFILESIZE=2000                # Size of history file

# Configure prompt
PS1='\u@\h:\w\$ '
```

**Why separate shell configs?**
- Each shell has different syntax and features
- Avoids errors when zsh/bash-specific features are used
- Allows shell-specific customization

---

## Git Configuration

### Understanding Git Config Levels

```bash
# System-wide (all users)
git config --system

# User-wide (your account)
git config --global   # File: ~/.config/git/config

# Repository-specific
git config --local    # File: .git/config
```

### Essential Git Customizations

```bash
# Set your identity (required)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Use SSH for authentication
git config --global url."git@github.com:".insteadOf "https://github.com/"

# Color output
git config --global color.ui true

# Set default branch name
git config --global init.defaultBranch main

# Set your editor
git config --global core.editor "code --wait"

# Configure diff tool
git config --global diff.tool vimdiff
git config --global difftool.prompt false

# Configure merge tool
git config --global merge.tool vimdiff
git config --global mergetool.prompt false

# Use rebase by default for pulls
git config --global pull.rebase true
```

### Create Useful Git Aliases

Add to [git/config](git/config) or use `git config --global alias`:

```bash
# Create aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"
git config --global alias.visual "log --graph --oneline --all"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.recentbranches "for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/"
```

**Why aliases?**
- Reduce typing for common operations
- Consistency across teams
- Encapsulate complex commands
- Faster workflow

---

## Editor Configuration

### VSCode Customization

**File**: [editor/vscode/settings.json](editor/vscode/settings.json)

VSCode settings that are useful to customize:

```json
{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[python]": {
    "editor.defaultFormatter": "ms-python.python",
    "editor.formatOnSave": true
  },
  "editor.fontSize": 12,
  "editor.fontFamily": "Fira Code, Menlo, Monaco",
  "editor.renderWhitespace": "selection",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "editor.rulers": [80, 120]
}
```

**Common customizations**:
- Font size and family
- Editor rulers (line length guides)
- Format on save behavior
- Theme and color scheme
- Extensions and their settings

### Vim Customization

**File**: [editor/vim/init.vim](editor/vim/init.vim)

```vim
" Basic settings
set number              " Show line numbers
set expandtab           " Convert tabs to spaces
set tabstop=4           " Tab width
set shiftwidth=4        " Indentation width
set autoindent          " Auto-indent new lines

" Search settings
set ignorecase          " Case-insensitive search
set smartcase           " Override ignorecase if uppercase used
set hlsearch            " Highlight search results

" Visual settings
set colorcolumn=80,120  " Show column guides

" Custom keybindings
nnoremap <C-n> :set number!<CR>  " Toggle line numbers
nnoremap ; :                       " Use ; instead of : for commands
```

**Tips for vim customization**:
- Start small—add one customization at a time
- Test changes immediately (use `:source %`)
- Use comments to explain non-obvious settings
- Use plugin managers for complex customizations

---

## Custom Scripts

### Creating Your Own Utility Scripts

**Location**: [bin/](bin/) directory

Create new scripts in `~/.dotfiles/bin/`:

```bash
#!/usr/bin/env bash
# My custom script
# Usage: my-script [options]

set -e

# Script logic here
echo "Hello from my custom script!"
```

**Make it executable**:
```bash
chmod +x ~/.dotfiles/bin/my-script
```

**Test it**:
```bash
~/.dotfiles/bin/my-script
```

### Example: Project Quick Start Script

```bash
#!/usr/bin/env bash
# new-project: Create a new project directory with standard structure

if [ $# -lt 1 ]; then
    echo "Usage: new-project <project-name>"
    exit 1
fi

PROJECT_NAME="$1"
PROJECTS_DIR="${PROJECTS_HOME:-$HOME/projects}"

mkdir -p "$PROJECTS_DIR/$PROJECT_NAME"
cd "$PROJECTS_DIR/$PROJECT_NAME"

# Create standard directories
mkdir -p src tests docs

# Create README
cat > README.md << EOF
# $PROJECT_NAME

## Description

Add project description here.

## Getting Started

Add getting started instructions.

## Development

Add development instructions.
EOF

# Initialize git (optional)
git init
git add README.md
git commit -m "Initial commit"

echo "✓ Project created: $PROJECTS_DIR/$PROJECT_NAME"
```

### Sharing Scripts with the Team

1. **Add to `bin/` directory**
2. **Make executable**: `chmod +x bin/my-script`
3. **Add documentation** in [bin/README.md](bin/README.md)
4. **Test thoroughly** before committing
5. **Commit to repository** for sharing

---

## OS-Specific Customization

### macOS Customizations

**File**: [macos/defaults.sh](macos/defaults.sh)

Default settings to apply on macOS:

```bash
# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true      # Show hidden files
defaults write com.apple.finder ShowPathbar -bool true            # Show path bar
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv # List view

# Dock
defaults write com.apple.dock autohide -bool true                 # Auto-hide dock
defaults write com.apple.dock pinning -string start               # Dock position

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2                    # Key repeat rate
defaults write NSGlobalDomain InitialKeyRepeat -int 25            # Initial key repeat delay

# Mission Control
defaults write com.apple.dock expose-animation-duration -float 0.1 # Faster Mission Control

# Apply changes
killall Dock
killall Finder
```

**Why use defaults?**
- Consistent system configuration across machines
- Faster than manual setup
- Reproducible environment
- Document your preferences in code

### Linux Package Customization

**File**: [linux/apt-packages.txt](linux/apt-packages.txt) or [linux/yum-packages.txt](linux/yum-packages.txt)

Add or remove packages by editing the list:

```bash
# Development tools
git
build-essential
curl
wget
vim
nano

# Programming languages
python3
python3-pip
nodejs
npm

# Utilities
jq
tmux
htop
tree
```

**Each line = one package**
- Comments start with `#`
- Installation script ignores empty lines
- Packages are OS-specific

### Detecting OS in Scripts

Use in your custom scripts:

```bash
source ~/.dotfiles/scripts/detect-os.sh

OS=$(detect_os)
DISTRO=$(detect_linux_distro)
SHELL_NAME=$(detect_shell)

case "$OS" in
    macos)
        echo "Running on macOS"
        # macOS-specific logic
        ;;
    linux)
        case "$DISTRO" in
            debian)
                echo "Running on Debian/Ubuntu"
                ;;
            rhel)
                echo "Running on RHEL/CentOS"
                ;;
        esac
        ;;
esac
```

---

## Advanced Configuration

### Creating a Private Customization Layer

Keep sensitive customizations (API keys, private aliases) out of version control:

```bash
# Create a private configuration file (not in git)
# ~/.zshrc
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/exports.sh
source ~/.zshrc.local   # Private customizations

# ~/.zshrc.local (add to .gitignore)
export PRIVATE_API_KEY="secret"
alias private-command="..."
```

Add to [.gitignore](git/ignore):
```bash
# Private shell configuration
.zshrc.local
.bashrc.local
.env.local
```

**Why this approach?**
- Keep secrets out of git
- Share public dotfiles, keep private configs local
- Different customizations per machine
- Safe to commit public dotfiles to GitHub

### Creating Machine-Specific Configurations

```bash
# ~/.zshrc - Load machine-specific config
MACHINE_NAME=$(hostname -s)

# Load machine-specific aliases if they exist
if [ -f ~/.dotfiles/shell/aliases.$MACHINE_NAME.sh ]; then
    source ~/.dotfiles/shell/aliases.$MACHINE_NAME.sh
fi

# Load machine-specific functions if they exist
if [ -f ~/.dotfiles/shell/functions.$MACHINE_NAME.sh ]; then
    source ~/.dotfiles/shell/functions.$MACHINE_NAME.sh
fi
```

Then create machine-specific files:
```bash
~/.dotfiles/shell/aliases.macbook.sh
~/.dotfiles/shell/aliases.workstation.sh
~/.dotfiles/shell/functions.dev-server.sh
```

**Benefits**:
- Share base configuration across machines
- Override with machine-specific settings
- Easy to manage multiple environments

### Conditional Configuration

Apply configurations based on environment:

```bash
# ~/.zshrc
# Work laptop configurations
if [ "$HOSTNAME" = "work-laptop" ]; then
    export WORK_MODE=true
    source ~/.dotfiles/shell/work-aliases.sh
fi

# Home laptop configurations
if [ "$HOSTNAME" = "home-laptop" ]; then
    export HOME_MODE=true
    source ~/.dotfiles/shell/personal-aliases.sh
fi

# Server configurations
if [ -n "$SSH_CLIENT" ]; then
    # This is an SSH session
    export REMOTE_SESSION=true
fi
```

---

## Sharing Your Customizations

### Option 1: Fork the Repository

```bash
# Fork on GitHub web interface
# Then clone your fork
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

**Advantages**:
- Full control over customizations
- Easy to merge upstream updates
- Shareable with others

### Option 2: Create a Branch for Customizations

```bash
# Create a branch for your customizations
git checkout -b my-customizations

# Make your changes
# Commit your changes
git add .
git commit -m "Add my personal customizations"

# Switch back to main for upstream updates
git checkout main
git pull origin main

# Merge your customizations
git merge my-customizations
```

### Option 3: Submodule for Organization-Specific Configs

```bash
# Create a separate repository for org-specific configs
mkdir ~/.dotfiles-org
cd ~/.dotfiles-org
git init

# Add organization-specific customizations
# Create structure matching ~/.dotfiles/
mkdir bin shell git

# Add to your shell config
echo 'source ~/.dotfiles-org/shell/aliases.sh' >> ~/.zshrc
```

---

## Testing Your Customizations

### Validate Shell Configuration

```bash
# Check for syntax errors
bash -n ~/.dotfiles/shell/aliases.sh
bash -n ~/.dotfiles/shell/functions.sh

# Test in a new shell
bash -c 'source ~/.dotfiles/shell/aliases.sh && alias myalias'
```

### Test Custom Scripts

```bash
# Make executable
chmod +x ~/.dotfiles/bin/my-script

# Run with bash -x for debugging
bash -x ~/.dotfiles/bin/my-script --help

# Check for common issues
shellcheck ~/.dotfiles/bin/my-script
```

### Dry-Run Mode for Dangerous Operations

```bash
# Build script with --dry-run mode
if [[ "$DRY_RUN" == "true" ]]; then
    echo "Would execute: $command"
else
    eval "$command"
fi
```

---

## Troubleshooting Customizations

### Changes Not Taking Effect

**Problem**: Modified aliases not appearing in shell

**Solution**:
```bash
# Reload shell configuration
source ~/.zshrc

# Or open a new terminal window
# Or restart your terminal application
```

### Syntax Errors in Configuration

**Problem**: Shell won't start or shows errors

**Solution**:
```bash
# Check for syntax errors
bash -n ~/.dotfiles/shell/aliases.sh
zsh -n ~/.zshrc

# Check which file has the error
bash -x ~/.zshrc 2>&1 | head -20

# Temporarily comment out the problematic line and restart
```

### Git Configuration Not Applied

**Problem**: Git config changes not recognized

**Solution**:
```bash
# Reload git (it auto-reloads, but verify)
git config --global --list | grep your-setting

# Check config file directly
cat ~/.config/git/config

# Verify symlink
ls -la ~/.config/git/config
```

### Custom Scripts Not Found

**Problem**: Script in bin/ not accessible

**Solution**:
```bash
# Verify script is executable
chmod +x ~/.dotfiles/bin/my-script

# Verify PATH includes the directory
echo $PATH | grep dotfiles

# Test direct invocation
~/.dotfiles/bin/my-script

# If PATH not updated, add to shell config
echo 'export PATH="$HOME/.dotfiles/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

---

## Next Steps

1. **Start small** — Make one or two customizations first
2. **Test changes** — Verify they work before committing
3. **Document** — Add comments explaining your customizations
4. **Share** — Contribute useful customizations back to the project
5. **Iterate** — Refine your setup over time based on your workflow

---

## Additional Resources

- [Shell Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)
- [Vim Configuration Guide](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
- [Git Configuration Reference](https://git-scm.com/docs/git-config)
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [ShellCheck — Shell script analyzer](https://www.shellcheck.net/)

