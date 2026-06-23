# Troubleshooting Guide

Comprehensive troubleshooting guide for common issues and their solutions.

## Table of Contents

- [Installation Issues](#installation-issues)
- [PATH and Script Issues](#path-and-script-issues)
- [Shell Configuration Issues](#shell-configuration-issues)
- [Git Configuration Issues](#git-configuration-issues)
- [Symlink and File Issues](#symlink-and-file-issues)
- [OS-Specific Issues](#os-specific-issues)
- [Performance Issues](#performance-issues)
- [Getting Help](#getting-help)

---

## Installation Issues

### Issue: "Permission denied: ./scripts/install.sh"

**Symptoms:**
```
bash: ./scripts/install.sh: Permission denied
-bash: scripts/install.sh: Permission denied
```

**Root Cause:**
- Script file doesn't have execute permission
- Common when git doesn't preserve file permissions

**Solution:**
```bash
# Make all scripts executable
chmod +x ~/.dotfiles/scripts/*.sh
chmod +x ~/.dotfiles/bin/*

# Try installation again
cd ~/.dotfiles
./scripts/install.sh
```

**Prevention:**
- Configure git to preserve permissions: `git config core.fileMode true`
- Use symlinks instead of copies when possible

---

### Issue: "OS not detected" or "unknown OS"

**Symptoms:**
```
Detected OS: unknown
Scripts not optimized for your system
```

**Root Cause:**
- OS detection script not working on your system
- Unusual environment (Codespaces, container, special Linux)

**Solution:**
```bash
# Check what your OS type is
echo $OSTYPE

# Run detection script directly
bash ~/.dotfiles/scripts/detect-os.sh

# Check Linux distribution
cat /etc/os-release | grep "^ID="

# If detection fails, manually specify
# Then skip automatic parts:
./scripts/install.sh --skip-packages
# And install packages manually
```

**Common outputs:**
- `darwin*` — macOS
- `linux-gnu` — Linux (Debian/Ubuntu/RHEL)
- Empty for Codespaces — Special case

---

### Issue: "Package installation fails"

**Symptoms:**
```
brew: command not found
apt-get: command not found
No package manager found
```

**Root Cause:**
- Package manager not installed
- Wrong OS detected
- Trying to install on unsupported system

**Solution:**

**For macOS (requires Homebrew):**
```bash
# Install Homebrew first
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then run dotfiles installation
./scripts/install.sh
```

**For Ubuntu/Debian:**
```bash
# Update package lists first
sudo apt-get update

# Then try installation
./scripts/install.sh
```

**For RHEL/CentOS:**
```bash
# Try with yum
sudo yum update

# Then try installation
./scripts/install.sh
```

**Skip package installation if unsupported:**
```bash
./scripts/install.sh --skip-packages
# Install packages manually
brew install git curl wget    # macOS
sudo apt-get install git curl wget  # Ubuntu
```

---

## PATH and Script Issues

### Issue: "Scripts not found" or "command not found"

**Symptoms:**
```
git-cleanup: command not found
setup-path: command not found
Cannot execute: No such file or directory
```

**Root Cause:**
- `~/.dotfiles/bin` not in PATH
- Shell not reloaded after adding to PATH
- Using wrong shell to start programs

**Diagnosis:**
```bash
# Check if PATH includes dotfiles
echo $PATH | grep dotfiles

# Expected output:
# /Users/username/.dotfiles/bin:/usr/local/bin:...

# If not in PATH, check shell config
cat ~/.zshrc | grep dotfiles    # For Zsh
cat ~/.bashrc | grep dotfiles   # For Bash

# Try to run script directly
~/.dotfiles/bin/git-cleanup --help
```

**Solution:**

**Option 1: Reload your shell**
```bash
# Fastest fix
source ~/.zshrc  # For Zsh
source ~/.bashrc # For Bash

# Or close and reopen terminal
```

**Option 2: Add to shell manually**
```bash
# Add to the end of ~/.zshrc or ~/.bashrc
echo 'export PATH="$HOME/.dotfiles/bin:$PATH"' >> ~/.zshrc

# Then reload
source ~/.zshrc
```

**Option 3: Use setup-path utility**
```bash
# Use full path to run it
~/.dotfiles/bin/setup-path

# Reload shell
source ~/.zshrc
```

**Verify it worked:**
```bash
which git-cleanup      # Should show path
echo $PATH | grep dotfiles  # Should show it
```

---

### Issue: "Wrong script is running"

**Symptoms:**
```
git-cleanup --help
# Shows different help than expected
# or runs system version instead of custom version
```

**Root Cause:**
- System has a script with same name earlier in PATH
- Custom script not executable
- PATH order is wrong

**Diagnosis:**
```bash
# Find all versions of the script
which -a git-cleanup

# Show PATH order
echo $PATH | tr ':' '\n'

# Check file status
ls -la ~/.dotfiles/bin/git-cleanup
```

**Solution:**
```bash
# Ensure custom script is executable
chmod +x ~/.dotfiles/bin/git-cleanup

# Make sure dotfiles/bin is early in PATH
# Edit ~/.zshrc and put this line early:
export PATH="$HOME/.dotfiles/bin:$PATH"

# Reload and verify
source ~/.zshrc
which git-cleanup        # Should show ~/.dotfiles/bin/git-cleanup
```

---

## Shell Configuration Issues

### Issue: "Aliases not working"

**Symptoms:**
```
$ ll
zsh: command not found: ll
$ alias ll
# No output (alias doesn't exist)
```

**Root Cause:**
- Aliases file not being sourced
- Shell not reloaded
- Syntax error in alias definition
- Using wrong shell

**Diagnosis:**
```bash
# Check if aliases are defined
alias ll
# If no output, they're not loaded

# Check if aliases file exists
cat ~/.dotfiles/shell/aliases.sh | head -10

# Test sourcing directly
bash ~/.dotfiles/shell/aliases.sh
alias ll  # Does it show now?
```

**Solution:**
```bash
# 1. Verify aliases file is sourced in shell config
grep "aliases.sh" ~/.zshrc
# Should show: source ~/.dotfiles/shell/aliases.sh

# 2. If not there, add it
echo 'source ~/.dotfiles/shell/aliases.sh' >> ~/.zshrc

# 3. Reload shell
source ~/.zshrc

# 4. Test
ll        # Should now work
alias ll  # Should show definition
```

**For specific shell:**
```bash
# Using Zsh
echo $SHELL  # Should show /bin/zsh

# Using Bash
echo $SHELL  # Should show /bin/bash

# Create shell-specific config if needed
# ~/.zshrc or ~/.bashrc
source ~/.dotfiles/shell/aliases.sh
```

---

### Issue: "Functions not working"

**Symptoms:**
```
$ mkcd ~/test
zsh: command not found: mkcd
$ declare -f mkcd
# No output (function doesn't exist)
```

**Root Cause:**
- Functions file not being sourced
- Shell not reloaded
- Bash-specific syntax in Zsh (or vice versa)
- Syntax error in function definition

**Diagnosis:**
```bash
# Check if function is defined
declare -f mkcd
# If no output, function isn't loaded

# Test if file has syntax errors
bash -n ~/.dotfiles/shell/functions.sh
# No output = syntax is OK

# Check specific function exists in file
grep -A 5 "^mkcd()" ~/.dotfiles/shell/functions.sh
```

**Solution:**
```bash
# 1. Verify functions file is sourced
grep "functions.sh" ~/.zshrc
# Should show: source ~/.dotfiles/shell/functions.sh

# 2. If not there, add it
echo 'source ~/.dotfiles/shell/functions.sh' >> ~/.zshrc

# 3. Test for syntax errors
bash -n ~/.dotfiles/shell/functions.sh

# 4. Reload shell
source ~/.zshrc

# 5. Test function
mkcd ~/test
pwd  # Should show /Users/username/test
```

**Note:** Functions in bash and zsh are mostly compatible, but some advanced features differ

---

### Issue: "Environment variables not set"

**Symptoms:**
```
$ echo $EDITOR
# Empty (not set)
$ env | grep EDITOR
# No output
```

**Root Cause:**
- Exports file not being sourced
- Variable not exported (just defined)
- Wrong shell config file

**Diagnosis:**
```bash
# Check if variable is set
echo $MY_VAR
# If empty, it's not set

# Check if exports file is being sourced
grep "exports.sh" ~/.zshrc
# Should show: source ~/.dotfiles/shell/exports.sh

# Check if variable is in exports file
grep "MY_VAR" ~/.dotfiles/shell/exports.sh
# Should show: export MY_VAR="value"

# Check if it's actually exported (not just defined)
# This is wrong: MY_VAR="value"
# This is right: export MY_VAR="value"
```

**Solution:**
```bash
# 1. Ensure exports file is sourced
grep "exports.sh" ~/.zshrc || echo 'source ~/.dotfiles/shell/exports.sh' >> ~/.zshrc

# 2. Verify variable is exported in exports.sh
# Edit ~/.dotfiles/shell/exports.sh and ensure:
export EDITOR="vim"    # Not just: EDITOR="vim"

# 3. Reload shell
source ~/.zshrc

# 4. Verify
echo $EDITOR  # Should show vim
```

---

## Git Configuration Issues

### Issue: "Git doesn't know your identity"

**Symptoms:**
```
error: Your name and email in git config. Please tell me who you are.
fatal: cannot do a partial commit while you are in the middle of a merge.
```

**Root Cause:**
- Git user.name or user.email not set
- Configuration file not found by git

**Solution:**
```bash
# Set your identity globally
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify it worked
git config --global user.name
git config --global user.email

# If using SSH signing, also set:
git config --global user.signingkey YOUR_GPG_KEY_ID
```

**To use a different identity for a specific project:**
```bash
cd /path/to/project
git config user.name "Different Name"
git config user.email "different@example.com"
```

---

### Issue: "Git config symlink not working"

**Symptoms:**
```
git config --list
# Doesn't show expected configuration
# or configuration not being used
```

**Root Cause:**
- Symlink not created properly
- Git looking in wrong location
- Symlink points to wrong file

**Diagnosis:**
```bash
# Check if symlink exists
ls -la ~/.config/git/config
# Should show: ~/.config/git/config -> ~/.dotfiles/git/config

# Check where git is looking
git config --list --show-origin | head -5

# Test if configuration is being read
git config --global user.name
# Should show configured name
```

**Solution:**
```bash
# 1. Create directory if needed
mkdir -p ~/.config/git

# 2. Remove old config if it exists
rm ~/.config/git/config

# 3. Create symlink
ln -s ~/.dotfiles/git/config ~/.config/git/config

# 4. Verify symlink
ls -la ~/.config/git/config
# Should show: ~/.config/git/config -> ~/.dotfiles/git/config

# 5. Test
git config --global user.name
```

**If you want git to use ~/. gitconfig instead:**
```bash
# Create/update ~/.gitconfig
git config --global core.excludesfile ~/.gitignore_global

# Link it to dotfiles
ln -s ~/.dotfiles/git/config ~/.gitconfig
```

---

## Symlink and File Issues

### Issue: "Cannot create symlink: File exists"

**Symptoms:**
```
ln: /Users/username/.zshrc: File exists
ln: /Users/username/.bashrc: File exists
```

**Root Cause:**
- Configuration file already exists
- Trying to create symlink where file already exists

**Solution:**
```bash
# 1. Check what exists
ls -la ~/.zshrc
# If it's a regular file, back it up

# 2. Backup existing file
cp ~/.zshrc ~/.zshrc.backup

# 3. Remove the existing file
rm ~/.zshrc

# 4. Create the symlink
ln -s ~/.dotfiles/shell/aliases.sh ~/.zsh_aliases
ln -s ~/.dotfiles/shell/exports.sh ~/.zsh_exports
ln -s ~/.dotfiles/shell/functions.sh ~/.zsh_functions

# 5. Update shell config to source these files
echo 'source ~/.zsh_aliases' >> ~/.zshrc
echo 'source ~/.zsh_exports' >> ~/.zshrc
echo 'source ~/.zsh_functions' >> ~/.zshrc
```

---

### Issue: "Symlink is broken" (points to non-existent file)

**Symptoms:**
```
ls -la ~/.zshrc
# lrwxr-xr-x ... ~/.zshrc -> /Users/wrong/path/.dotfiles/shell/aliases.sh
# (The path shown in red/with different formatting)
```

**Root Cause:**
- Symlink points to wrong location
- Dotfiles moved or cloned in different location
- Relative symlink used with moved directory

**Solution:**
```bash
# 1. Find where dotfiles actually is
ls ~/.dotfiles
# If not found, find it:
find ~ -maxdepth 2 -name "dotfiles" -type d

# 2. Check broken symlink
ls -la ~/.zshrc
# Note the target path

# 3. Remove broken symlink
rm ~/.zshrc

# 4. Create new symlink with correct path
ln -s ~/.dotfiles/shell/aliases.sh ~/.zsh_aliases
# Use absolute paths, not relative

# 5. Verify symlink
ls -la ~/.zsh_aliases
# Should show correct path
```

---

## OS-Specific Issues

### macOS Issues

#### Issue: "Homebrew command not found"

**Solution:**
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to PATH if needed
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify
brew --version
```

#### Issue: "macOS defaults not applied"

**Solution:**
```bash
# Apply defaults
bash ~/.dotfiles/macos/defaults.sh

# Some changes require logout/login or restart
# Restart specific apps:
killall Dock
killall Finder
killall SystemUIServer
```

---

### Linux Issues

#### Issue: "apt-get not found" (on RHEL/CentOS)

**Solution:**
```bash
# You need to use yum instead
sudo yum install git curl wget

# Or let the script detect it
./scripts/install.sh
# It should use yum automatically
```

#### Issue: "Permission denied for /usr/local/bin"

**Solution:**
```bash
# Check permissions
ls -ld /usr/local/bin

# Fix if needed
sudo chown $USER /usr/local/bin
sudo chmod u+w /usr/local/bin

# Or use ~/.local/bin instead
mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
ln -s ~/.dotfiles/bin/git-cleanup ~/.local/bin/
```

---

## Performance Issues

### Issue: "Shell startup is slow"

**Symptoms:**
```
# Takes 5+ seconds to open a new terminal
# Especially first terminal of the day
```

**Diagnosis:**
```bash
# Find slow parts
time zsh -i -c exit

# See which files are slow
zsh -x -i -c exit 2>&1 | tail -20
```

**Solutions:**
```bash
# 1. Check if all sourced files exist
# Edit ~/.zshrc and look for source commands
# Make sure all sourced files exist:
test -f ~/.dotfiles/shell/aliases.sh || echo "aliases.sh missing"

# 2. Lazy load slow commands
# Instead of: source ~/.dotfiles/shell/functions.sh
# Use: [ -f ~/.dotfiles/shell/functions.sh ] && source ~/.dotfiles/shell/functions.sh

# 3. Use conditional loading
if [[ -o interactive ]]; then
    source ~/.dotfiles/shell/aliases.sh
fi

# 4. Remove unnecessary aliases/functions
# Keep only what you actually use
```

---

## Getting Help

### Information to Gather

When reporting issues, provide:

1. **Your system**
   ```bash
   uname -s      # OS
   uname -m      # Architecture
   ```

2. **Your shell**
   ```bash
   echo $SHELL
   $SHELL --version
   ```

3. **Error messages** (full text)
   ```bash
   # Run with output capturing
   ./scripts/install.sh 2>&1 | tee error.log
   ```

4. **Affected file or script**
   ```bash
   which git-cleanup    # Location
   file ~/.zshrc        # Type
   ```

5. **What you tried**
   - Installation method used
   - Commands run before error
   - Changes you made

### Debugging Steps

```bash
# 1. Check file syntax
bash -n ~/.dotfiles/shell/aliases.sh
zsh -n ~/.zshrc

# 2. Run with debugging
bash -x ~/.dotfiles/scripts/install.sh 2>&1 | head -50

# 3. Check environment
env | grep -i path
env | grep -i shell

# 4. List relevant files
ls -la ~/
ls -la ~/.dotfiles/
ls -la ~/.config/

# 5. Search for error in file
grep -r "error message" ~/.dotfiles/
```

### Useful Diagnostic Commands

```bash
# Overall system info
uname -a

# Current shell and path
echo $SHELL
echo $PATH

# Check if symlinks are correct
ls -la ~/.zshrc
ls -la ~/.config/git/config

# Verify git setup
git config --list

# Check if scripts are executable
ls -la ~/.dotfiles/bin/
ls -la ~/.dotfiles/scripts/

# Test shell config loading
source ~/.zshrc && echo "Config loaded OK"

# Check for conflicts
which -a git-cleanup    # Show all instances
alias ll               # Show alias definition
declare -f mkcd       # Show function definition
```

---

## Still Having Issues?

If you've tried these solutions:

1. **Review the main guides:**
   - [SETUP_GUIDE.md](SETUP_GUIDE.md)
   - [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)
   - [SHELL_CONFIGURATION_REFERENCE.md](SHELL_CONFIGURATION_REFERENCE.md)

2. **Check script help:**
   ```bash
   ./scripts/install.sh --help
   git-cleanup --help
   setup-path --help
   ```

3. **Collect diagnostic information** (see above)

4. **Search GitHub issues** for similar problems

5. **Open an issue** with:
   - System information
   - What you're trying to do
   - Exact error message
   - Steps to reproduce
   - What you've already tried

