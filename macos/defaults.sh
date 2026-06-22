#!/usr/bin/env bash
# macOS system defaults
# Apply common preferences for macOS

set -e

log_info() {
    echo "[INFO] $1"
}

log_info "Applying macOS defaults..."

# Finder: show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Dock: set icon size
defaults write com.apple.dock tilesize -int 48

# Dock: enable magnification
defaults write com.apple.dock magnification -bool true

# Dock: set magnification size
defaults write com.apple.dock largesize -int 64

# Dock: auto-hide
defaults write com.apple.dock autohide -bool true

# Keyboard: disable autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Keyboard: faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Save to disk by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

log_info "macOS defaults applied!"
log_info "Some changes require a restart to take effect."
