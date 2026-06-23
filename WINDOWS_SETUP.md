# Windows 11 Setup Guide - Scripted Installation

This guide covers automated setup for Windows 11 using either WSL2 or Git Bash, with comprehensive installation scripts.

## Quick Comparison

| Method | Setup Effort | Compatibility | Recommended |
|--------|-------------|---------------|------------|
| **WSL2** | Moderate | Full (Linux environment) | ✅ YES |
| **Git Bash** | Low | Limited (Windows MSYS2) | ⚠️ Basic use only |

## WSL2 Setup (Recommended)

### Prerequisites

- Windows 11 (22000 or later)
- Administrator access
- Virtualization enabled in BIOS

### Automated Installation

#### Step 1: Enable WSL2 in PowerShell

```powershell
# Run PowerShell as Administrator (Win+X, then A)
wsl --install
wsl --set-default-version 2
wsl --install -d Ubuntu-22.04
```

After restart, open Windows Terminal and select Ubuntu from the dropdown.

#### Step 2: Clone and Run Setup Script

```bash
# In WSL2 Ubuntu terminal
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Preview what will be installed
./scripts/install.sh --dry-run

# Run full installation
./scripts/install.sh
```

### What the Script Does

The `setup-windows-wsl2.sh` script automatically:

✅ Verifies WSL2 environment is properly set up
✅ Installs Linux packages (apt for Ubuntu/Debian, yum for others)
✅ Configures your shell (Bash or Zsh)
✅ Creates symlinks for all configuration files
✅ Sets up git configuration
✅ Provides Windows Terminal integration tips
✅ Verifies the installation

### Manual Configuration (Optional)

If you want to skip automatic package installation:

```bash
./scripts/install.sh --skip-packages
```

## Git Bash Setup (Alternative)

### Prerequisites

- Windows 11
- Git for Windows installed
- Administrator access (for some operations)

### Automated Installation

#### Step 1: Install Git for Windows

Download and run the installer from https://git-scm.com/download/win

#### Step 2: Clone and Run Setup Script

```bash
# In Git Bash terminal
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Preview what will be installed
bash ./scripts/install.sh --dry-run

# Run installation
bash ./scripts/install.sh
```

### What the Script Does

The `setup-windows-git-bash.sh` script automatically:

✅ Verifies Git Bash environment
✅ Configures `.bashrc` with dotfiles sourcing
✅ Sets up git configuration
✅ Copies (not links) configuration files for Windows compatibility
✅ Provides Windows Terminal integration instructions
✅ Shows Git Bash limitations and recommendations
✅ Verifies the installation

### Important Notes for Git Bash

- **Symlinks**: Configuration files are copied, not symlinked (Windows limitation)
- **Path differences**: Uses Windows path handling
- **Limited features**: Some shell features may not work

### Limitations

⚠️ Git Bash has these limitations:
- Some shell built-ins behave differently
- Full Linux compatibility not available
- Docker integration limited
- Some GNU utilities not available

**Recommendation**: If you run into issues, consider WSL2 for full compatibility.

## Script Options

Both setup scripts support:

```bash
./scripts/setup-windows-wsl2.sh --dry-run      # Preview changes
./scripts/setup-windows-git-bash.sh --dry-run  # Preview changes
```

## File Locations

After setup, configuration files are located at:

| Component | Location |
|-----------|----------|
| Dotfiles repository | `~/.dotfiles/` |
| Shell config | `~/.bashrc` or `~/.zshrc` |
| Git config | `~/.config/git/config` |
| Gitignore | `~/.gitignore_global` |
| Custom scripts | `~/.dotfiles/bin/` |

## Verification

### WSL2

```bash
# Check PATH includes dotfiles
echo $PATH | grep dotfiles

# Verify git config
git config --global user.name
git config --global user.email

# Test custom scripts
which git-cleanup
which dotfiles-sync
```

### Git Bash

```bash
# Check configuration was applied
grep "dotfiles" ~/.bashrc

# Verify git is available
git --version

# Reload shell to test
source ~/.bashrc
```

## Troubleshooting

### WSL2

#### "The Windows Subsystem for Linux has not been installed"

```powershell
# Enable WSL2
wsl --install
# Restart computer
# Set default version
wsl --set-default-version 2
```

#### Symlinks not working

WSL2 home directory symlinks work fine. If you cloned into `/mnt/c/`, move to home:

```bash
cp -r ~/.dotfiles ~/.dotfiles-backup
cd ~
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
```

### Git Bash

#### Changes not taking effect

```bash
# Close and reopen Git Bash, or:
source ~/.bashrc
```

#### Path issues

```bash
# Verify Git Bash path
echo $PATH

# Add dotfiles to path manually
echo 'export PATH="$HOME/.dotfiles/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Post-Installation

1. **Configure Git Identity** (both methods):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. **Reload Shell**:
   ```bash
   source ~/.bashrc     # Git Bash or WSL2 with Bash
   source ~/.zshrc      # WSL2 with Zsh
   ```

3. **Test Setup**:
   ```bash
   echo $PATH           # Should include ~/.dotfiles/bin
   which git-cleanup    # Should find the script
   ```

4. **Customize**:
   - Read [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)
   - Add your own aliases and functions

## Windows Terminal Configuration

### For WSL2

1. Open Windows Terminal Settings (Ctrl+,)
2. Go to "Defaults" profile
3. Set your Ubuntu distribution as default
4. Adjust font (recommend: Cascadia Code)
5. Enable "Copy on select" under Interaction

### For Git Bash

1. Open Windows Terminal Settings (Ctrl+,)
2. Click "Add new profile" → "New empty profile"
3. Set these fields:
   - **Name**: Git Bash
   - **Command line**: `C:\Program Files\Git\bin\bash.exe -i -l`
   - **Starting directory**: `%USERPROFILE%`
4. Click Save

## Next Steps

- Read [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed setup information
- Check [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md) to personalize
- See [bin/README.md](bin/README.md) for available utility scripts

## Support

For issues or questions:

1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Review script output (--dry-run mode for details)
3. Open an issue on GitHub with:
   - Output of `wsl --status` (WSL2) or `echo $OSTYPE` (Git Bash)
   - Full error messages
   - Steps to reproduce

## Recommendation

**For the best experience, use WSL2.** It provides:
- Full Linux environment on Windows
- Complete shell compatibility
- All tools and scripts work identically
- Docker integration
- Modern approach for Windows development

