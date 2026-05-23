#!/usr/bin/env bash
# yuzhou-mac-theme installer
# Sets up Ghostty + zsh + Starship + eza with sensible defaults.
#
# Usage:
#   bash install.sh
#
# Idempotent: safe to re-run. Existing configs are backed up with a timestamp.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"

log() { printf "\033[1;34m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!!\033[0m %s\n" "$*" >&2; }

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew is on PATH for the rest of this script
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 2. Packages
log "Installing CLI tools..."
brew install \
  starship \
  eza \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  gh

# 3. Nerd Font
log "Installing JetBrainsMono Nerd Font..."
brew install --cask font-jetbrains-mono-nerd-font || true

# 4. Link configs (back up existing ones first)
link_config() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    warn "Backing up existing $dst -> $dst.backup-$TS"
    mv "$dst" "$dst.backup-$TS"
  elif [ -L "$dst" ]; then
    rm "$dst"
  fi
  ln -s "$src" "$dst"
  log "Linked $dst -> $src"
}

link_config "$REPO_DIR/zshrc" "$HOME/.zshrc"
link_config "$REPO_DIR/ghostty/config" "$HOME/.config/ghostty/config"

log "Done. Restart Ghostty and open a new shell:"
echo "  exec zsh"
