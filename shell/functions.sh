# Shell functions

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick edit dotfiles
edit_dotfiles() {
    ${EDITOR:-vim} "${DOTFILES_DIR}"
}

# Quick view git log
glog() {
    git log --oneline -n "${1:-10}"
}

# Add more functions as needed
