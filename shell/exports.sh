# Shell exports and environment variables

# Ensure dotfiles directory is available
export DOTFILES_DIR="${HOME}/.dotfiles"

# Editor
export EDITOR=vim
export VISUAL=vim

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Add custom bin to PATH
[[ ":$PATH:" != *":${DOTFILES_DIR}/bin:"* ]] && export PATH="${DOTFILES_DIR}/bin:${PATH}"

# Add local bin to PATH
[[ ":$PATH:" != *":${HOME}/.local/bin:"* ]] && export PATH="${HOME}/.local/bin:${PATH}"

# Color support
export CLICOLOR=1
export CLICOLOR_FORCE=1
