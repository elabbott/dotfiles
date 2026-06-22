# Bash Configuration
# This is a template - customize as needed

# History configuration
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

# Load shell functions and exports
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
[[ -f "$DOTFILES_DIR/shell/exports.sh" ]] && source "$DOTFILES_DIR/shell/exports.sh"
[[ -f "$DOTFILES_DIR/shell/aliases.sh" ]] && source "$DOTFILES_DIR/shell/aliases.sh"
[[ -f "$DOTFILES_DIR/shell/functions.sh" ]] && source "$DOTFILES_DIR/shell/functions.sh"

# Local overrides
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"

# Prompt (customize as needed)
PS1='\u@\h \W $ '
