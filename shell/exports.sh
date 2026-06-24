# Shell exports and environment variables

# Detect dotfiles directory - use already-set value or look in standard locations
if [[ -z "$DOTFILES_DIR" ]]; then
    # Try ~/.dotfiles first (standard location)
    if [[ -d "${HOME}/.dotfiles" ]]; then
        export DOTFILES_DIR="${HOME}/.dotfiles"
    # Fall back to the current script's parent directory
    elif [[ -d "${BASH_SOURCE[0]%/*}/.." ]]; then
        export DOTFILES_DIR="$(cd "${BASH_SOURCE[0]%/*}/.." && pwd)"
    else
        export DOTFILES_DIR="${HOME}/.dotfiles"
    fi
else
    export DOTFILES_DIR="$DOTFILES_DIR"
fi

# Editor
export EDITOR=vim
export VISUAL=vim
# GPG configuration
export GPG_TTY=$(tty)
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
