# VSCode Setup

## Installation

### macOS / Linux

VSCode settings are typically stored in platform-specific locations. The simplest approach is to:

**Option 1: Manual copy**
1. Open VSCode settings: `Cmd+Comma` (macOS) or `Ctrl+Comma` (Linux)
2. Click the "Open Settings (JSON)" icon in the top-right
3. Copy the contents of [settings.json](settings.json) into your settings
4. Repeat for keybindings: `Cmd+K Cmd+S`, then "Open Keybindings (JSON)"

**Option 2: Symlink (advanced)**
```bash
# macOS
ln -s ~/.dotfiles/editor/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
ln -s ~/.dotfiles/editor/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"

# Linux
ln -s ~/.dotfiles/editor/vscode/settings.json ~/.config/Code/User/settings.json
ln -s ~/.dotfiles/editor/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

### GitHub Codespaces

Settings automatically sync in Codespaces via VS Code Settings Sync. Configuration is included in [devcontainer.json](../../codespaces/devcontainer.json).

## Features

### Editor Settings
- Format on save with Prettier
- Tab size: 2 spaces (configurable per language)
- Line rulers at 80 and 120 characters
- Smart indentation
- Auto-trim trailing whitespace
- Insert final newline

### Language-Specific Settings
- **JavaScript/TypeScript** — 2 spaces, Prettier formatting
- **Python** — 4 spaces, Black formatting
- **JSON** — 2 spaces, Prettier formatting
- **Markdown** — Word wrap, Prettier formatting
- **YAML** — 2 spaces

### Terminal Integration
- Terminal font matches editor
- Default shell: zsh (macOS), bash (Linux)
- Font size: 12pt

### Extensions
Recommended extensions are listed in `settings.json` and configured in [codespaces/extensions.json](../../codespaces/extensions.json).

## Customization

Edit `settings.json` to customize:
- Theme and icon theme
- Font and font size
- Editor behavior
- Language-specific settings
- Extension settings

Edit `keybindings.json` to customize keyboard shortcuts.

## Common Shortcuts

- `Cmd+Shift+P` — Command palette
- `Cmd+Shift+L` — Go to symbol
- `Cmd+1/2/3` — Focus editor group
- `Cmd+J` — Toggle panel
- `Ctrl+\`` — Toggle sidebar
- `Ctrl+Shift+\`` — New terminal
