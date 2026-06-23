#!/usr/bin/env bash

# Flatpak Permission Overrides
# Configures common permission overrides for Flatpak applications
# Usage: ./permission-overrides.sh [app-id] [--show|--reset|--apply]

set -euo pipefail

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
  echo -e "${BLUE}=== $1 ===${NC}"
}

print_info() {
  echo -e "${YELLOW}ℹ $1${NC}"
}

print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

# Common app permissions configurations
declare -A APP_PERMISSIONS=(
  ["org.mozilla.firefox"]="--filesystem=home --filesystem=/tmp --share=network --socket=wayland --socket=x11"
  ["com.visualstudio.code"]="--filesystem=home --filesystem=/tmp --share=network --socket=wayland --socket=x11"
  ["org.gnome.gedit"]="--filesystem=home"
  ["org.thunderbird.Thunderbird"]="--filesystem=home --share=network --socket=wayland --socket=x11"
  ["com.github.gittyup"]="--filesystem=home --socket=wayland --socket=x11"
  ["io.github.liferooter.Pithesaurz"]="--filesystem=home --socket=wayland --socket=x11"
  ["com.github.PintaProject.Pinta"]="--filesystem=home --socket=wayland --socket=x11"
  ["io.mpv.Mpv"]="--filesystem=home --share=network --socket=wayland --socket=x11 --socket=pulseaudio"
  ["io.dbeaver.DBeaverCommunity"]="--filesystem=home --share=network --socket=wayland --socket=x11"
  ["org.libreoffice.LibreOffice"]="--filesystem=home --socket=wayland --socket=x11"
)

# Function to display current permissions
show_permissions() {
  local app_id="$1"
  print_header "Permissions for $app_id"
  flatpak override --show "$app_id" || echo "No overrides configured"
}

# Function to apply standard permissions
apply_permissions() {
  local app_id="$1"

  if [ -z "${APP_PERMISSIONS[$app_id]:-}" ]; then
    print_info "No predefined permissions for $app_id"
    return 1
  fi

  print_info "Applying permissions to $app_id..."
  # shellcheck disable=SC2086
  flatpak override $app_id ${APP_PERMISSIONS[$app_id]}
  print_success "Permissions applied to $app_id"
}

# Function to reset permissions
reset_permissions() {
  local app_id="$1"
  print_info "Resetting permissions for $app_id..."
  flatpak override --reset "$app_id"
  print_success "Permissions reset for $app_id"
}

# Function to apply filesystem access
set_filesystem() {
  local app_id="$1"
  local path="$2"
  print_info "Granting filesystem access to $path for $app_id..."
  flatpak override "$app_id" --filesystem="$path"
  print_success "Filesystem access granted"
}

# Function to revoke filesystem access
revoke_filesystem() {
  local app_id="$1"
  local path="$2"
  print_info "Revoking filesystem access to $path from $app_id..."
  flatpak override "$app_id" --nofilesystem="$path"
  print_success "Filesystem access revoked"
}

# Function to apply network access
set_network() {
  local app_id="$1"
  print_info "Granting network access to $app_id..."
  flatpak override "$app_id" --share=network
  print_success "Network access granted"
}

# Function to display help
show_help() {
  cat <<EOF
${BLUE}Flatpak Permission Overrides${NC}

Configures permissions for Flatpak applications using Flatseal-style overrides.

${BLUE}Usage:${NC}
  $0 [OPTION]
  $0 app-id [--show|--reset|--apply]

${BLUE}Options:${NC}
  --list              List all apps with predefined permissions
  --list-all          List all installed Flatpak apps
  --apply-all         Apply all predefined permissions
  --help              Show this help message

${BLUE}App ID Commands:${NC}
  $0 app-id --show     Display current permissions
  $0 app-id --apply    Apply predefined permissions
  $0 app-id --reset    Reset to default permissions
  $0 app-id --filesystem /path   Grant filesystem access
  $0 app-id --no-filesystem /path Revoke filesystem access

${BLUE}Examples:${NC}
  # Show Firefox permissions
  $0 org.mozilla.firefox --show

  # Apply predefined permissions to VS Code
  $0 com.visualstudio.code --apply

  # Grant home directory access to an app
  $0 app-id --filesystem \$HOME

  # Revoke network access
  $0 app-id --no-filesystem /tmp

${BLUE}Common Permissions:${NC}
  --filesystem=home       Access to home directory
  --filesystem=/tmp       Access to /tmp
  --share=network         Network access
  --socket=wayland        Wayland socket
  --socket=x11            X11 socket
  --socket=pulseaudio     Audio playback

EOF
}

# List available apps with predefined permissions
list_predefined() {
  print_header "Apps with Predefined Permissions"
  for app in "${!APP_PERMISSIONS[@]}"; do
    echo "  $app"
  done | sort
}

# List all installed Flatpak apps
list_all_apps() {
  print_header "All Installed Flatpak Applications"
  flatpak list --app --columns=application,name
}

# Apply permissions to all predefined apps
apply_all_permissions() {
  print_header "Applying All Predefined Permissions"
  for app_id in "${!APP_PERMISSIONS[@]}"; do
    if flatpak list --app | grep -q "$app_id"; then
      echo "Applying permissions to $app_id..."
      apply_permissions "$app_id"
    fi
  done
  print_success "All permissions applied"
}

# Main function
main() {
  if [ $# -eq 0 ]; then
    show_help
    exit 0
  fi

  case "$1" in
    --list)
      list_predefined
      ;;
    --list-all)
      list_all_apps
      ;;
    --apply-all)
      apply_all_permissions
      ;;
    --help | -h)
      show_help
      ;;
    *)
      # Check if it's an app ID
      local app_id="$1"
      local action="${2:-}"

      case "$action" in
        --show)
          show_permissions "$app_id"
          ;;
        --apply)
          apply_permissions "$app_id"
          ;;
        --reset)
          reset_permissions "$app_id"
          ;;
        --filesystem)
          set_filesystem "$app_id" "${3:-$HOME}"
          ;;
        --no-filesystem)
          revoke_filesystem "$app_id" "${3:-/tmp}"
          ;;
        *)
          print_info "Unknown action: $action"
          echo ""
          show_help
          exit 1
          ;;
      esac
      ;;
  esac
}

main "$@"
