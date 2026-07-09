# Linux Configuration

Linux-specific configurations for various distributions.

## Directories & Files

### Package Management
- `apt-packages.txt` — Packages to install via apt (Debian/Ubuntu)
- `yum-packages.txt` — Packages to install via yum (RedHat/CentOS)
- `pacman-packages.txt` — Packages to install via pacman (Arch Linux)
- `aur-packages.txt` — Packages to install from AUR (Arch Linux)

### Flatpak Setup
Flatpak provides sandboxed, universal Linux applications across all distributions.

- **[flatpak/README.md](flatpak/README.md)** — Flatpak setup guide
- `flatpak/flatpak-apps.txt` — List of recommended Flatpak applications
- `flatpak/flatpak-setup.sh` — Automated Flatpak installation script
- `flatpak/permission-overrides.sh` — Permission management for Flatpak apps

## Quick Start

### Install Flatpak
```bash
# Automatic setup with recommended apps
cd linux/flatpak
./flatpak-setup.sh --full

# Or install specific setup type
./flatpak-setup.sh --dev      # Development tools
./flatpak-setup.sh --minimal  # Essential apps only
```

### Manage Flatpak Permissions
```bash
# View all available apps with predefined permissions
./permission-overrides.sh --list

# Apply permissions to an app
./permission-overrides.sh com.visualstudio.code --apply

# Show current permissions
./permission-overrides.sh org.mozilla.firefox --show
```

## Usage

Use distribution-specific package lists for traditional package managers. For universal, sandboxed applications, see the Flatpak setup guide.

### Arch Linux

For Arch Linux users, packages are divided into:
- **Official repositories** (`pacman-packages.txt`) — Packages available in the official Arch repos
- **AUR packages** (`aur-packages.txt`) — Packages from the Arch User Repository

**AUR Helper Required**: To install AUR packages, you need an AUR helper like `paru` or `yay`. 

Install `paru`:
```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

Or install `yay`:
```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Then run the main installation script, which will automatically detect Arch and install both official and AUR packages:
```bash
cd ~/.dotfiles
./scripts/install.sh
```
