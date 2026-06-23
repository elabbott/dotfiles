#!/usr/bin/env bash

# Flatpak Setup Script
# Installs Flatpak and recommended applications
# Usage: ./flatpak-setup.sh [--dev|--minimal|--full]

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPS_FILE="${SCRIPT_DIR}/flatpak-apps.txt"
SETUP_TYPE="${1:-full}"

# Functions
print_header() {
  echo -e "${BLUE}=== $1 ===${NC}"
}

print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
  echo -e "${RED}✗ $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠ $1${NC}"
}

check_command() {
  if ! command -v "$1" &>/dev/null; then
    return 1
  fi
  return 0
}

install_flatpak() {
  print_header "Installing Flatpak"

  if check_command flatpak; then
    print_success "Flatpak is already installed"
    return 0
  fi

  # Detect OS and install accordingly
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      ubuntu | debian)
        print_warning "Installing Flatpak via apt..."
        sudo apt update
        sudo apt install -y flatpak
        ;;
      fedora)
        print_warning "Installing Flatpak via dnf..."
        sudo dnf install -y flatpak
        ;;
      arch | manjaro)
        print_warning "Installing Flatpak via pacman..."
        sudo pacman -S --noconfirm flatpak
        ;;
      opensuse*)
        print_warning "Installing Flatpak via zypper..."
        sudo zypper install -y flatpak
        ;;
      *)
        print_error "Unsupported distribution: $ID"
        print_warning "Please install Flatpak manually: https://docs.flatpak.org/en/latest/getting-started.html"
        return 1
        ;;
    esac
  else
    print_error "Could not detect OS"
    return 1
  fi

  print_success "Flatpak installed successfully"
}

add_flathub_repo() {
  print_header "Adding Flathub Repository"

  if flatpak remote-list | grep -q flathub; then
    print_success "Flathub repository is already added"
    return 0
  fi

  print_warning "Adding Flathub repository..."
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  print_success "Flathub repository added"
}

install_apps() {
  local setup_type="$1"

  print_header "Installing Flatpak Applications ($setup_type)"

  if [ ! -f "$APPS_FILE" ]; then
    print_error "Apps file not found: $APPS_FILE"
    return 1
  fi

  local count=0
  local installed=0
  local failed=0

  while IFS= read -r app; do
    # Skip empty lines and comments
    [[ "$app" =~ ^#.*$ || -z "$app" ]] && continue

    # Filter by setup type
    case "$setup_type" in
      dev)
        [[ "$app" =~ ^#.*Development ]] && continue || true
        ;;
      minimal)
        # Only install essentials for minimal setup
        [[ "$app" =~ ^#.*Essentials ]] || continue
        ;;
    esac

    count=$((count + 1))
    app_id=$(echo "$app" | awk '{print $1}')

    if flatpak list --app | grep -q "$app_id"; then
      print_warning "Already installed: $app_id"
      continue
    fi

    echo -n "Installing $app_id... "
    if flatpak install -y flathub "$app_id" &>/dev/null; then
      print_success "$app_id"
      installed=$((installed + 1))
    else
      print_error "$app_id"
      failed=$((failed + 1))
    fi
  done <"$APPS_FILE"

  echo ""
  print_header "Installation Summary"
  echo "Total apps processed: $count"
  echo "Successfully installed: $installed"
  echo "Failed: $failed"
}

update_all() {
  print_header "Updating Flatpak and Applications"
  flatpak update -y
  print_success "All applications updated"
}

install_flatseal() {
  print_header "Installing Flatseal (Permission Manager)"

  if flatpak list --app | grep -q "flatseal"; then
    print_success "Flatseal is already installed"
    return 0
  fi

  print_warning "Installing Flatseal..."
  flatpak install -y flathub com.github.tchx84.Flatseal
  print_success "Flatseal installed"
}

show_usage() {
  cat <<EOF
${BLUE}Flatpak Setup Script${NC}

Usage: $0 [OPTION]

Options:
  --dev       Install development tools only
  --minimal   Install minimal set of essential apps
  --full      Install all recommended apps (default)
  --help      Show this help message

Examples:
  $0 --dev        # Development setup
  $0 --minimal    # Minimal setup
  $0              # Full setup

EOF
}

# Main execution
main() {
  case "$SETUP_TYPE" in
    --help | -h)
      show_usage
      exit 0
      ;;
    --dev | --minimal | --full)
      # Continue with setup
      ;;
    *)
      print_error "Unknown option: $SETUP_TYPE"
      show_usage
      exit 1
      ;;
  esac

  print_header "Flatpak Setup Script"

  install_flatpak || exit 1
  add_flathub_repo
  install_flatseal
  install_apps "${SETUP_TYPE#--}"
  update_all

  print_header "Setup Complete! 🎉"
  echo "To launch Flatseal and manage permissions:"
  echo "  flatpak run com.github.tchx84.Flatseal"
  echo ""
  echo "List installed flatpaks:"
  echo "  flatpak list --app"
}

main
