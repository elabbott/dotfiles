# Editor Configuration

Configuration files for various editors.

## Subdirectories

- **vim/** — Vim configuration (.vimrc)
- **nvim/** — Neovim configuration (init.vim and init.lua)
- **vscode/** — Visual Studio Code settings and keybindings

## Supported Editors

### Vim
Traditional Vi IMproved editor configuration with:
- Syntax highlighting
- Smart indentation
- Split window management
- Customizable key mappings

**Setup:** See [vim/README.md](vim/README.md)

### Neovim
Modern Vim fork with Lua support and improved defaults.
Includes both VimScript (init.vim) and Lua (init.lua) configurations.

**Setup:** See [nvim/README.md](nvim/README.md)

### Visual Studio Code
Full VSCode configuration including:
- Editor settings (formatting, indentation, colors)
- Custom keybindings
- Language-specific configurations
- Extension recommendations

**Setup:** See [vscode/README.md](vscode/README.md)

## Quick Start

```bash
# Vim
ln -s ~/.dotfiles/editor/vim/.vimrc ~/.vimrc

# Neovim (choose one)
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/editor/nvim/init.lua ~/.config/nvim/init.lua

# VSCode - see vscode/README.md for platform-specific instructions
```

## Features

All configurations share common settings:
- 2-space indentation (except Python which uses 4)
- Syntax highlighting
- Line number display
- Search highlighting
- File-type detection
- Local overrides support

## Adding More Editors

To add configurations for other editors (Emacs, Sublime, etc.):
1. Create a new subdirectory under `editor/`
2. Add configuration files
3. Create a README.md with setup instructions
4. Update this README with the new editor
