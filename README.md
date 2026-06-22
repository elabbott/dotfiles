# dotfiles

Universal dotfiles for macOS, Linux, and GitHub Codespaces. Quickly bootstrap your development environment across multiple machines and projects.

## Directory Structure

```
dotfiles/
├── shell/              # Shell configurations (zsh, bash)
├── git/                # Git configuration and hooks
├── editor/             # Editor configs (vim, VSCode, etc.)
├── macos/              # macOS-specific configurations
├── linux/              # Linux-specific configurations
├── codespaces/         # GitHub Codespaces-specific setup
├── scripts/            # Installation and utility scripts
├── bin/                # Executable scripts and tools
└── README.md           # This file
```

## Directories

- **shell/** — Shell profiles, aliases, functions, and prompt configurations
- **git/** — Git config, aliases, and hooks
- **editor/** — Settings for vim, VSCode, and other editors
- **macos/** — Preferences, defaults, and tools specific to macOS
- **linux/** — Configurations for Linux distributions
- **codespaces/** — Setup files for GitHub Codespaces (devcontainer.json, etc.)
- **scripts/** — Installation and bootstrap scripts
- **bin/** — Custom executables and utility scripts

## Quick Start

### macOS / Linux

Clone the repository and run the installation script:

```bash
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/install.sh
```

The script will:
- Detect your OS (macOS, Linux)
- Install packages (Homebrew on macOS, apt/yum on Linux)
- Link dotfiles to your home directory
- Apply OS-specific configurations

**Preview changes first:**
```bash
./scripts/install.sh --dry-run
```

**Installation options:**
```bash
./scripts/install.sh --skip-packages   # Skip package installation
./scripts/install.sh --skip-link       # Skip dotfile linking
```

### GitHub Codespaces

The repository includes a `devcontainer.json` configuration that automatically sets up Codespaces:

1. Open the repository in Codespaces
2. The environment will automatically initialize with:
   - All required development tools
   - VSCode extensions configured
   - Shell and git configurations linked
   - Dotfiles available at `~/.dotfiles`

### Manual Setup

If you prefer to set up manually or use specific components:

**Link shell configurations:**
```bash
ln -s ~/.dotfiles/shell/.zshrc ~/.zshrc
ln -s ~/.dotfiles/shell/.bashrc ~/.bashrc
```

**Link git configuration:**
```bash
mkdir -p ~/.config/git
ln -s ~/.dotfiles/git/config ~/.config/git/config
ln -s ~/.dotfiles/git/ignore ~/.gitignore_global
```

**Link custom bin directory:**
```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
```

## Customization

Edit the configuration files directly in the repository:

- **Shell aliases**: `shell/aliases.sh`
- **Shell functions**: `shell/functions.sh`
- **Environment variables**: `shell/exports.sh`
- **Git config**: `git/config` (update user name/email)
- **macOS defaults**: `macos/defaults.sh`
- **Packages**: `macos/homebrew.txt`, `linux/apt-packages.txt`, `linux/yum-packages.txt`

### Local Overrides

Create local override files that won't be tracked:

```bash
~/.zshrc.local       # Local zsh configuration
~/.bashrc.local      # Local bash configuration
```

These are sourced automatically if they exist.

## Usage

After installation, your dotfiles are available in two ways:

1. **Linked to home directory** — Files are symlinked so they update automatically
2. **In the repository** — Edit at `~/.dotfiles/` or your clone location

Changes to files in the repository automatically apply to linked locations.

## File Structure

- **shell/.zshrc** / **shell/.bashrc** — Main shell configuration
- **shell/exports.sh** — Environment variables and PATH
- **shell/aliases.sh** — Common command aliases
- **shell/functions.sh** — Utility shell functions
- **git/config** — Git configuration (user, aliases, settings)
- **git/ignore** — Global git ignore rules
- **macos/defaults.sh** — macOS system preferences
- **macos/homebrew.txt** — Homebrew packages to install
- **linux/apt-packages.txt** — Debian/Ubuntu packages
- **linux/yum-packages.txt** — RHEL/CentOS packages
- **codespaces/devcontainer.json** — Codespaces configuration
- **codespaces/init.sh** — Codespaces initialization script

## Updating

To update your dotfiles to the latest version:

```bash
cd ~/.dotfiles
git pull origin main
```

## Support

For issues or improvements, open an issue or create a pull request on GitHub.
