# Installation and Utility Scripts

Scripts for installing, linking, and maintaining dotfiles across macOS, Linux, GitHub Codespaces, and Windows 11.

## Files

### Core Installation Scripts

- **`install.sh`** — Main installation script
  - Detects operating system (macOS, Linux, WSL2, Git Bash, Codespaces)
  - Delegates to OS-specific setup scripts
  - Installs packages via appropriate package manager
  - Creates symlinks for dotfile configurations
  - Applies OS-specific defaults
  - Usage: `./install.sh [--dry-run] [--skip-packages] [--skip-link]`

- **`detect-os.sh`** — Operating system detection utility
  - Detects: macOS, Linux, WSL2, Windows (Git Bash), GitHub Codespaces
  - Detects Linux distributions (Debian, RHEL, etc.)
  - Detects shell (bash, zsh, fish)
  - Exportable functions for use in other scripts
  - Usage: `bash detect-os.sh` (outputs OS name)

### Linking Scripts

- **`link-dotfiles.sh`** — Creates symlinks for dotfile configurations
  - Intelligently handles existing files (creates backups)
  - Supports symlink limitations on Windows (Git Bash)
  - Creates parent directories as needed
  - Usage: `bash link-dotfiles.sh [DOTFILES_DIR] [DRY_RUN]`

### Windows 11 Specific Scripts

- **`setup-windows-wsl2.sh`** — Windows 11 setup using WSL2 (Recommended)
  - Checks WSL2 environment and compatibility
  - Installs Linux packages (apt or yum)
  - Configures shell (Bash or Zsh)
  - Creates proper symlinks in WSL2
  - Integrates with Windows Terminal
  - Usage: `bash setup-windows-wsl2.sh [--dry-run]`

- **`setup-windows-git-bash.sh`** — Windows 11 setup using Git Bash
  - Checks Git Bash environment
  - Configures Bash shell
  - Handles Windows file paths
  - Sets up git configuration for Windows
  - Usage: `bash setup-windows-git-bash.sh [--dry-run]`

## Quick Start

```bash
git clone https://github.com/elabbott/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/install.sh --dry-run
./scripts/install.sh
```

## Platform-Specific Installation

### macOS

```bash
./scripts/install.sh
```

### Linux

```bash
./scripts/install.sh
```

### Windows 11 with WSL2 (Recommended)

```bash
cd ~/.dotfiles
./scripts/install.sh
```

### Windows 11 with Git Bash

```bash
cd ~/.dotfiles
bash ./scripts/install.sh
```

### GitHub Codespaces

```bash
cd ~/.dotfiles
./scripts/install.sh
```

## Script Options

- `--dry-run` — Preview changes without modifying system
- `--skip-packages` — Skip package installation
- `--skip-link` — Skip dotfile linking

## How It Works

1. **Detection**: `install.sh` detects your OS and environment
2. **Delegation**: For Windows, delegates to appropriate setup script
3. **Installation**: Installs packages based on platform
4. **Linking**: Creates symlinks or copies files as appropriate
5. **Configuration**: Applies OS-specific defaults

## See Also

- [SETUP_GUIDE.md](../SETUP_GUIDE.md) — Complete installation guide
- [CUSTOMIZATION_GUIDE.md](../CUSTOMIZATION_GUIDE.md) — How to customize
- [ARCHITECTURE.md](../ARCHITECTURE.md) — Design and philosophy
