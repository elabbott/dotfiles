# Zsh Configuration
# This is a template - customize as needed

# Enable command substitution in prompts
setopt PROMPT_SUBST

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit && compinit

# Load shell functions and exports
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
[[ -f "$DOTFILES_DIR/shell/exports.sh" ]] && source "$DOTFILES_DIR/shell/exports.sh"
[[ -f "$DOTFILES_DIR/shell/aliases.sh" ]] && source "$DOTFILES_DIR/shell/aliases.sh"
[[ -f "$DOTFILES_DIR/shell/functions.sh" ]] && source "$DOTFILES_DIR/shell/functions.sh"

# Local overrides
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Prompt (customize as needed)
PROMPT='%n@%m %~ $ '
