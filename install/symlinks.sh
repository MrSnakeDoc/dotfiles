#!/usr/bin/env bash
set -euo pipefail
trap 'echo "❌ Error on line $LINENO"; exit 1' ERR

# ==================================================
# Options
# ==================================================

BACKUP_EXISTING="${BACKUP_EXISTING:-false}"

while getopts "b" opt; do
  case "$opt" in
  b) BACKUP_EXISTING=true ;;
  *)
    echo "Usage: $0 [-k]"
    exit 1
    ;;
  esac
done

# ==================================================
# Paths
# ==================================================

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
CONFIG="${CONFIG:-$HOME/.config}"

mkdir -p "$CONFIG"

# ==================================================
# Helpers
# ==================================================

log() {
  printf "%b\n" "$1"
}

create_symlink() {
  local source="$1"
  local destination="$2"

  if [[ ! -e "$source" ]]; then
    log "⚠ Missing source: $source"
    return 1
  fi

  mkdir -p "$(dirname "$destination")"

  # Already correct → noop
  if [[ -L "$destination" && "$(readlink "$destination")" == "$source" ]]; then
    log "✔ already linked: $destination"
    return 0
  fi

  # Remove existing destination (surgical)
  if [[ -L "$destination" ]]; then
    log "↺ removing old symlink: $destination"
    rm "$destination"

  elif [[ -e "$destination" ]]; then
    if [[ "$BACKUP_EXISTING" == "true" ]]; then
      backup="${destination}.backup.$(date +%s)"
      log "⚠ backup $destination → $backup"
      mv "$destination" "$backup"
    else
      log "✘ removing existing file/dir: $destination"
      rm -rf "$destination"
    fi
  fi

  log "➜ linking $destination → $source"
  ln -s "$source" "$destination"
}

# ==================================================
# Managed links (single source of truth)
# ==================================================

declare -A LINKS=(
  ["$DOTFILES/.zshrc"]="$HOME/.zshrc"
  ["$DOTFILES/.config/zsh"]="$HOME/.zsh"
  ["$DOTFILES/.config/atuin/config.toml"]="$CONFIG/atuin/config.toml"
  ["$DOTFILES/.config/starship.toml"]="$CONFIG/starship.toml"
  ["$DOTFILES/.config/keg"]="$CONFIG/keg"
  ["$DOTFILES/.config/nvim"]="$CONFIG/nvim"
  ["$DOTFILES/.config/zellij"]="$CONFIG/zellij"
  ["$DOTFILES/.config/herdr"]="$CONFIG/herdr"

)

# ==================================================
# Execution
# ==================================================

log "🔗 Creating symlinks..."

for src in "${!LINKS[@]}"; do
  create_symlink "$src" "${LINKS[$src]}"
done

log "✅ Symlinks created successfully."
