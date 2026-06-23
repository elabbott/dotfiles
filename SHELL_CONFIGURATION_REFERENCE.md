# Shell Configuration Reference

Complete reference guide for shell configuration, environment variables, aliases, and functions.

## Table of Contents

- [Overview](#overview)
- [Configuration Files](#configuration-files)
- [Environment Variables](#environment-variables)
- [Aliases](#aliases)
- [Functions](#functions)
- [Best Practices](#best-practices)
- [Advanced Topics](#advanced-topics)
- [Troubleshooting](#troubleshooting)

---

## Overview

Shell configuration in this repository is modular and works across multiple shells:

- **Zsh** (default on macOS)
- **Bash** (widely available)
- **Fish** (optional, supported for PATH setup)

### Why Modular?

Breaking configuration into separate files:
- **Easier to maintain** — Each file has one responsibility
- **Reusable** — Can be sourced in different shells
- **Flexible** — Easy to add/remove configurations
- **Portable** — Works across different systems

### Configuration Files

| File | Purpose | Shell Compatibility |
|------|---------|-------------------|
| `shell/aliases.sh` | Command shortcuts | Bash, Zsh, Fish |
| `shell/exports.sh` | Environment variables | Bash, Zsh, Fish |
| `shell/functions.sh` | Shell functions | Bash, Zsh only |

---

## Configuration Files

### Understanding the Shell Config Stack

When you open a shell, these files are loaded in order:

1. **System defaults** — Set by your OS
2. **Shell initialization** — Shell-specific setup
3. **Dotfiles configuration** — Your custom configuration
4. **Local overrides** — Machine-specific configuration

### Zsh Configuration

**Main config file:** `~/.zshrc`

```bash
# ~/.zshrc - Sourced in interactive zsh shells

# Source dotfiles configurations
source ~/.dotfiles/shell/exports.sh
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/functions.sh

# Zsh-specific configurations
setopt HIST_IGNORE_DUPS      # Don't save duplicate commands
setopt AUTO_CD               # Type directory name to cd
setopt CORRECT               # Auto-correct typos

# Completions (optional, requires completion framework)
autoload -Uz compinit && compinit

# Prompt (if not using prompt framework)
PROMPT='%n@%m:%~%# '
```

**Why these options?**
- `HIST_IGNORE_DUPS` — Cleaner history
- `AUTO_CD` — Faster directory navigation
- `CORRECT` — Reduces typos

### Bash Configuration

**Main config file:** `~/.bashrc`

```bash
# ~/.bashrc - Sourced in interactive bash shells

# Source dotfiles configurations
source ~/.dotfiles/shell/exports.sh
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/functions.sh

# Bash-specific configurations
shopt -s histappend          # Append to history
shopt -s checkwinsize        # Check window size
HISTSIZE=1000                # Keep 1000 commands
HISTFILESIZE=2000            # History file size

# Prompt
PS1='\u@\h:\w\$ '
```

---

## Environment Variables

**Location:** [shell/exports.sh](../shell/exports.sh)

Environment variables control tool behavior across all commands and applications.

### Essential Variables

#### `PATH`

**What it is:** Directories to search for executables

```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
```

**Why modify it?**
- Add custom scripts to PATH (like dotfiles/bin)
- Prioritize newer tools over system versions
- Add language-specific tools

**Order matters:**
- Earlier directories override later ones
- Add `~/.dotfiles/bin` early to prioritize custom scripts

#### `EDITOR`

**What it is:** Default editor for commands that need to edit text

```bash
export EDITOR="vim"          # For command-line editing
export VISUAL="code"         # For visual editing
```

**Why customize?**
- Different tools use these for different purposes
- `git commit` uses `EDITOR`
- Some tools use `VISUAL` instead

#### `SHELL`

**What it is:** Your current shell

```bash
export SHELL="/usr/bin/zsh"
```

**Note:** Usually set automatically; only override if needed

#### `HOME`

**What it is:** Your home directory

```bash
export HOME="$HOME"          # Usually already set
```

**Why use it?**
- Reference in paths as `$HOME` instead of `~`
- More portable across systems
- Clear in scripts what's being referenced

#### `LC_ALL` and `LANG`

**What they are:** Language and locale settings

```bash
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
```

**Why set them?**
- Ensures UTF-8 encoding (important for non-ASCII characters)
- Fixes encoding issues with tools
- Critical for international text support

### Development Tool Variables

#### Python

```bash
# Prevent Python from buffering output
export PYTHONUNBUFFERED=1

# Enable development mode
export PYTHONDONTWRITEBYTECODE=1

# Specify Python version for tools
export PYTHON_VERSION=3.9
```

#### Node.js / npm

```bash
# npm package cache
export npm_config_cache="$HOME/.npm"

# Prevent npm warnings
export npm_config_loglevel="warn"
```

#### Rust

```bash
# Show backtraces on panic
export RUST_BACKTRACE=1

# Log level for rust compiler
export RUST_LOG=debug
```

#### Go

```bash
# Go workspace
export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"

# Add Go binaries to PATH
export PATH="$GOPATH/bin:$PATH"
```

### Custom Project Variables

Add project-specific paths:

```bash
# Project directories
export PROJECTS_HOME="$HOME/projects"
export WORK_HOME="$HOME/work"
export DOTFILES_HOME="$HOME/.dotfiles"

# Quick access
export MYPROJECT="$PROJECTS_HOME/my-awesome-project"
```

Then use in commands:

```bash
cd $PROJECTS_HOME
cd $MYPROJECT
```

---

## Aliases

**Location:** [shell/aliases.sh](../shell/aliases.sh)

Aliases are shortcuts for commands you use frequently. They save typing and make workflows faster.

### Creating Aliases

**Basic syntax:**
```bash
alias shortname="full command"
```

**Important:** No spaces around `=`

### Navigation Aliases

```bash
# Shorter cd commands
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Common directories
alias proj="cd ~/projects"
alias work="cd ~/work"
alias dl="cd ~/Downloads"
alias dev="cd ~/Developer"
```

### List Aliases

```bash
# Default ls is boring
alias ls='ls -G'              # Enable colors (macOS)
alias ls='ls --color=auto'    # Enable colors (Linux)

# List variations
alias la='ls -lAh'            # All files, long format, human-readable
alias ll='ls -lh'             # Long format, human-readable
alias lla='ls -lAh'           # Same as la
alias lt='ls -lth'            # Sort by time
alias ltr='ls -ltr'           # Reverse time sort (oldest first)
```

**Why these?**
- `-l` — Long format (permissions, owner, size, date)
- `-A` — All files (including hidden, except . and ..)
- `-h` — Human-readable sizes (KB, MB, etc.)
- `-G` / `--color` — Color output for easy scanning
- `-t` — Sort by time
- `-r` — Reverse order

### Git Aliases

```bash
# Single letter commands
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline'
alias gstash='git stash'
alias gpop='git stash pop'
```

**Why git aliases?**
- Git is used constantly
- Single-letter shortcuts save significant typing
- Make common operations feel effortless
- Faster workflow

**Usage examples:**
```bash
g status              # git status
g add .               # git add .
gc "commit message"   # git commit -m "commit message"
gp                    # git push
gpl                   # git pull
```

### File Manipulation Aliases

```bash
# Safety: confirm before destructive operations
alias rm='rm -i'              # Ask before deleting
alias mv='mv -i'              # Ask before overwriting
alias cp='cp -i'              # Ask before overwriting

# Create directories with parent paths
alias mkdir='mkdir -pv'       # -p: create parents, -v: verbose

# Better grep
alias grep='grep --color=auto'

# Better diff
alias diff='diff --color=auto'
```

**Why these safeguards?**
- Prevent accidental data loss
- `-i` flag asks for confirmation
- `-v` shows what happened
- `-p` prevents errors with nested paths

### Development Aliases

```bash
# Quick development server start
alias dev="npm run dev"
alias test="npm run test"
alias build="npm run build"

# Python
alias python="python3"        # Use Python 3 by default
alias pip="pip3"

# Docker
alias d="docker"
alias dc="docker-compose"

# Open in editor
alias code="code ."           # Open current directory in VSCode
alias vim="vim ."             # Open current directory in Vim
```

### Aliases to Use with Caution

Be careful with these:

```bash
# Only if you really know what you're doing
# alias rm='rm -rf'            # DANGEROUS: Deletes without asking
# alias sudo=''                # DANGEROUS: Defeats security

# These can be confusing
# alias cd='cd && ls'          # Changes behavior of normal command
# alias ls='ls -la'            # Too much output by default
```

**General rule:** Aliases should enhance, not change fundamental behavior

---

## Functions

**Location:** [shell/functions.sh](../shell/functions.sh)

Functions are more powerful than aliases—they can accept arguments and use complex logic.

### Creating Functions

**Basic syntax:**
```bash
function_name() {
    # Function body
    echo "Hello from function"
}
```

**Alternative syntax:**
```bash
function function_name {
    echo "Hello from function"
}
```

### Arguments in Functions

```bash
my_function() {
    echo "First argument: $1"
    echo "Second argument: $2"
    echo "All arguments: $@"
    echo "Number of arguments: $#"
}
```

**Argument variables:**
- `$1`, `$2`, `$3` — Individual arguments
- `$@` or `$*` — All arguments
- `$#` — Number of arguments
- `$0` — Function name

### Useful Functions

#### Directory and File Operations

```bash
# Create directory and enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    case "$1" in
        *.tar.bz2)  tar xjf "$1" ;;
        *.tar.gz)   tar xzf "$1" ;;
        *.tar)      tar xf "$1"  ;;
        *.zip)      unzip "$1"   ;;
        *.7z)       7z x "$1"    ;;
        *)          echo "Unknown format: $1" ;;
    esac
}

# Remove file and related files
# (with confirmation)
rmfamily() {
    echo "Files matching '$1':"
    find . -name "*$1*" -type f
    read -p "Delete these? (y/n) " -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        find . -name "*$1*" -type f -delete
        echo "Deleted."
    fi
}
```

#### Process Management

```bash
# Search processes by name
psgrep() {
    ps aux | grep -i "$1" | grep -v grep
}

# Kill process by name
killname() {
    kill -9 $(pgrep -f "$1")
}
```

#### Git Functions

```bash
# Clone and enter repository
gitclone() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

# Delete local and remote branch
gitdelboth() {
    git branch -d "$1"
    git push origin --delete "$1"
}

# Show git log with graph
gitlog() {
    git log --graph --oneline --all --decorate
}
```

#### Development Functions

```bash
# Start a simple HTTP server
httpserver() {
    PORT=${1:-8000}
    python3 -m http.server $PORT
}

# Create Python virtual environment
pyvenv() {
    python3 -m venv "$1" && source "$1/bin/activate"
}

# Show port usage
portinfo() {
    lsof -i :$1 2>/dev/null || echo "No process on port $1"
}
```

### Using Functions in Scripts

Functions are just as useful in bash scripts:

```bash
#!/bin/bash
# myscript.sh

# Define function
install_deps() {
    if command -v brew &> /dev/null; then
        brew install "$@"
    elif command -v apt &> /dev/null; then
        apt-get install "$@"
    fi
}

# Use function
install_deps git curl wget

# Define another function
build_project() {
    echo "Building..."
    npm install
    npm run build
}

# Use it
build_project
```

---

## Best Practices

### 1. Use Descriptive Names

**Good:**
```bash
alias lah='ls -lah'      # Clear abbreviation
function mkcd() { }      # Name describes action
```

**Avoid:**
```bash
alias x='exit'           # Unclear
alias foobar() { }       # Meaningless name
```

### 2. Document Your Configuration

Add comments explaining why:

```bash
# Don't buffer Python output so logs appear immediately
export PYTHONUNBUFFERED=1

# Use Vim for editing git commits
export EDITOR=vim

# Add .local/bin for user-installed tools
export PATH="$HOME/.local/bin:$PATH"
```

### 3. Keep Aliases Simple

**Good:**
```bash
alias ll='ls -lh'
```

**Avoid:**
```bash
# Too complex for an alias—should be a function
alias deploy='git add . && git commit -m "Deploy" && git push && ssh myserver "cd app && ./deploy.sh"'
```

### 4. Order Exports Strategically

PATH order matters:

```bash
# Custom tools first (have priority)
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Then language-specific tools
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# System paths come last
```

### 5. Avoid Unsafe Defaults

**Don't:**
```bash
alias rm='rm -rf'        # Silently deletes entire trees!
alias cp='mv'            # Unexpected behavior
```

**Do:**
```bash
alias rm='rm -i'         # Ask before deleting
alias mkdir='mkdir -p'   # Create needed parent dirs
```

### 6. Test Aliases and Functions

Before committing:

```bash
# Test alias
source ~/.dotfiles/shell/aliases.sh
ll                       # Does it work?

# Test function
source ~/.dotfiles/shell/functions.sh
mkcd /tmp/test-dir      # Does it create and enter dir?
cd -                    # Go back
```

### 7. Use Shell-Specific Features Appropriately

**Bash and Zsh compatible:**
```bash
export VARIABLE="value"
alias cmd="command"
```

**Bash only:**
```bash
shopt -s globstar
declare -A associative_array
```

**Zsh only:**
```bash
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
```

---

## Advanced Topics

### Conditional Configuration

Apply configuration based on the environment:

```bash
# Only on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
fi

# Only on Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias ls='ls --color=auto'
fi

# Only when SSH session
if [ -n "$SSH_CLIENT" ]; then
    # SSH-specific configuration
    export EDITOR=nano  # nano is always available
fi
```

### Machine-Specific Configuration

Create machine-specific files that aren't in git:

```bash
# ~/.zshrc
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/exports.sh

# Load machine-specific config if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
```

Then create `~/.zshrc.local` with machine-specific settings:

```bash
# ~/.zshrc.local (not in git)
export WORK_DIR="/path/to/work"
export PRIVATE_TOKEN="secret"
alias mywork="cd $WORK_DIR"
```

### Lazy Loading

For rarely-used commands, load them on demand:

```bash
# Lazy load Python virtualenv
venv() {
    if [ -z "$VIRTUAL_ENV" ]; then
        source bin/activate
    fi
}

# Lazy load nvm (Node Version Manager)
nvm() {
    unset -f nvm
    [ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"
    nvm "$@"
}
```

---

## Troubleshooting

### Alias Not Working

```bash
# Check if alias exists
alias myalias

# Verify it's defined in the file
grep "alias myalias" ~/.dotfiles/shell/aliases.sh

# Reload shell configuration
source ~/.zshrc

# Try directly
eval "alias myalias=\"command\""
```

### Function Not Found

```bash
# Check if function exists
declare -f myfunction

# Verify syntax is correct
bash -n ~/.dotfiles/shell/functions.sh

# Reload shell configuration
source ~/.dotfiles/shell/functions.sh
```

### Environment Variable Not Set

```bash
# Check if variable exists
echo $MY_VAR

# Verify it's exported
grep "export MY_VAR" ~/.dotfiles/shell/exports.sh

# Set directly to test
export MY_VAR="value"
echo $MY_VAR

# Reload shell configuration
source ~/.dotfiles/shell/exports.sh
```

### PATH Issues

```bash
# Check current PATH
echo $PATH

# Show PATH as lines for easier reading
echo $PATH | tr ':' '\n'

# Add directory to PATH
export PATH="/path/to/add:$PATH"

# Verify new directory is first
echo $PATH | tr ':' '\n' | head -5
```

---

## References

- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Zsh Manual](https://zsh.sourceforge.io/Doc/Release/index.html)
- [Fish Shell Documentation](https://fishshell.com/docs/current/)

---

## Next Steps

1. **Customize aliases** — Edit [shell/aliases.sh](../shell/aliases.sh)
2. **Add functions** — Edit [shell/functions.sh](../shell/functions.sh)
3. **Set variables** — Edit [shell/exports.sh](../shell/exports.sh)
4. **Test changes** — `source ~/.zshrc` and verify
5. **See examples** — Check [CUSTOMIZATION_GUIDE.md](../CUSTOMIZATION_GUIDE.md#shell-configuration)

