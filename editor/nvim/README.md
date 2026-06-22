# Neovim Setup

## Installation

Link the Neovim configuration:

**For init.vim (VimScript):**
```bash
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/editor/nvim/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim/undo
```

**For init.lua (Lua):**
```bash
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/editor/nvim/init.lua ~/.config/nvim/init.lua
mkdir -p ~/.config/nvim/undo
```

## Features

- Syntax highlighting with 24-bit color support
- Line numbers (absolute and relative)
- Smart indentation (2 spaces by default)
- Search highlighting with smart case
- Undo history persistence
- Split window management
- Keyboard mappings with space as leader key
- File type specific settings

## Choosing Between init.vim and init.lua

- **init.vim** — Traditional VimScript-based configuration
- **init.lua** — Modern Lua-based configuration (recommended for Neovim)

Use one or the other, not both.

## Customization

Edit the configuration file to customize:
- Editor behavior
- Key mappings
- Plugin management (lazy.nvim, packer.nvim, etc.)
- LSP setup
- Treesitter configuration

## Common Commands

- `<leader>w` — Save file
- `<leader>q` — Quit
- `<leader>/` — Clear search highlighting
- `<C-h/j/k/l>` — Navigate between splits
- `<C-arrow>` — Resize splits
