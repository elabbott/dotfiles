# Vim Setup

## Installation

Link the Vim configuration to your home directory:

```bash
ln -s ~/.dotfiles/editor/vim/.vimrc ~/.vimrc
mkdir -p ~/.vim/undo
```

## Features

- Syntax highlighting with 24-bit color support
- Line numbers (absolute and relative)
- Smart indentation (2 spaces by default)
- Search highlighting with smart case
- Column rulers at 80 and 120 characters
- Undo history persistence
- Split window management
- Keyboard mappings with space as leader key

## Customization

Edit `.vimrc` to customize:
- Color scheme
- Key mappings
- Editor behavior
- Plugin settings

## Common Commands

- `<leader>w` — Save file
- `<leader>q` — Quit
- `<leader>/` — Clear search highlighting
- `<C-h/j/k/l>` — Navigate between splits
- `<C-arrow>` — Resize splits
