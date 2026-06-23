# Flatpak Configuration

Flatpak setup and recommended applications for sandboxed, universal Linux application distribution.

## About Flatpak

Flatpak is a universal package manager for Linux that provides:
- **Sandboxed applications** for improved security
- **Universal compatibility** across all Linux distributions
- **Easy updates** managed through Flatseal
- **Consistent experience** across systems

**Documentation:** https://docs.flatpak.org/

## Files

- `flatpak-apps.txt` — List of recommended Flatpak applications to install
- `permission-overrides.sh` — Script to manage Flatpak permissions with Flatseal
- `flatpak-setup.sh` — Helper script for Flatpak installation and management

## Installation

### 1. Install Flatpak

**Ubuntu/Debian:**
```bash
sudo apt install flatpak
```

**Fedora:**
```bash
sudo dnf install flatpak
```

**Arch:**
```bash
sudo pacman -S flatpak
```

### 2. Add Flathub Repository

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

### 3. Install Recommended Applications

```bash
# Using the helper script
./linux/flatpak/flatpak-setup.sh

# Or manually install from flatpak-apps.txt
while IFS= read -r app; do
  [[ "$app" =~ ^#.*$ || -z "$app" ]] && continue
  flatpak install -y flathub "$app"
done < linux/flatpak/flatpak-apps.txt
```

### 4. Install Flatseal (Permission Manager)

```bash
flatpak install -y flathub com.github.tchx84.Flatseal
```

### 5. Configure Permissions

Use Flatseal GUI or apply override configs:
```bash
./linux/flatpak/permission-overrides.sh
```

## Common Applications

See `flatpak-apps.txt` for the full list. Popular development apps include:
- `org.gnome.gedit` — Text editor
- `com.visualstudio.code` — VS Code
- `com.github.PintaProject.Pinta` — Image editor
- `org.thunderbird.Thunderbird` — Email client
- `org.mozilla.firefox` — Browser

## Managing Flatpak Permissions

Use **Flatseal** GUI for visual permission management, or configure via command line:

```bash
# View app permissions
flatpak override --show org.mozilla.firefox

# Grant filesystem access
flatpak override org.mozilla.firefox --filesystem=home

# Revoke permissions
flatpak override org.mozilla.firefox --nofilesystem=home
```

## Uninstalling Applications

```bash
# List installed flatpaks
flatpak list --app

# Uninstall specific app
flatpak uninstall org.mozilla.firefox
```

## Troubleshooting

### Flatpak not found
Ensure flatpak is in your PATH:
```bash
which flatpak
```

### Permission denied errors
Use `--user` flag for per-user installation:
```bash
flatpak install --user flathub org.mozilla.firefox
```

### Update all apps
```bash
flatpak update
```

## Resources

- [Flatpak Official Documentation](https://docs.flatpak.org/)
- [Flathub Repository](https://flathub.org/)
- [Flatseal Permissions Manager](https://github.com/tchx84/flatseal)
