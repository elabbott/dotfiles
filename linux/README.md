# Linux Configuration

Linux-specific configurations for various distributions.

## Directories & Files

### Package Management
- `apt-packages.txt` — Packages to install via apt (Debian/Ubuntu)
- `yum-packages.txt` — Packages to install via yum (RedHat/CentOS)

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
