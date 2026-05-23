#!/usr/bin/env bash
# yuzhou-mac-theme installer (macOS + Linux)
#
# Usage:  bash install.sh
# Idempotent: safe to re-run. Existing configs are backed up with a timestamp.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
OS="$(uname -s)"

log()  { printf "\033[1;34m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!!\033[0m %s\n"  "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

# ---------- macOS ----------------------------------------------------------
install_macos() {
  if ! have brew; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  if   [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew    ]; then eval "$(/usr/local/bin/brew shellenv)"
  fi

  log "Installing CLI tools via Homebrew..."
  brew install starship eza zsh-autosuggestions zsh-syntax-highlighting gh

  log "Installing JetBrainsMono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font || true
}

# ---------- Linux ----------------------------------------------------------
install_linux() {
  local DISTRO_ID="" DISTRO_LIKE=""
  if [ -r /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID="${ID:-}"
    DISTRO_LIKE="${ID_LIKE:-}"
  fi

  case "$DISTRO_ID $DISTRO_LIKE" in
    *debian*|*ubuntu*)
      log "Detected Debian/Ubuntu — using apt"
      sudo apt-get update
      sudo apt-get install -y zsh git curl unzip fontconfig \
        zsh-autosuggestions zsh-syntax-highlighting
      sudo apt-get install -y eza 2>/dev/null || warn "eza not in apt; install manually or via cargo"
      sudo apt-get install -y gh  2>/dev/null || warn "gh not in apt; see https://cli.github.com/"
      ;;
    *fedora*|*rhel*|*centos*)
      log "Detected Fedora/RHEL — using dnf"
      sudo dnf install -y zsh git curl unzip fontconfig \
        zsh-autosuggestions zsh-syntax-highlighting eza gh
      ;;
    *arch*)
      log "Detected Arch — using pacman"
      sudo pacman -S --needed --noconfirm zsh git curl unzip fontconfig \
        zsh-autosuggestions zsh-syntax-highlighting eza github-cli
      ;;
    *)
      warn "Unknown distro ($DISTRO_ID). Please install manually:"
      warn "  zsh git curl unzip fontconfig zsh-autosuggestions zsh-syntax-highlighting eza gh"
      ;;
  esac

  if ! have starship; then
    log "Installing Starship (official installer)..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
  fi

  install_nerd_font_linux
}

install_nerd_font_linux() {
  if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd Font"; then
    log "JetBrainsMono Nerd Font already installed"
    return
  fi
  log "Installing JetBrainsMono Nerd Font..."
  local font_dir="$HOME/.local/share/fonts"
  local tmp; tmp="$(mktemp -d)"
  mkdir -p "$font_dir/JetBrainsMonoNerdFont"
  curl -fsSL -o "$tmp/JBM.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -qo "$tmp/JBM.zip" -d "$font_dir/JetBrainsMonoNerdFont"
  rm -rf "$tmp"
  fc-cache -f "$font_dir"
}

# ---------- Dispatch -------------------------------------------------------
case "$OS" in
  Darwin) install_macos ;;
  Linux)  install_linux ;;
  *)      warn "Unsupported OS: $OS"; exit 1 ;;
esac

# ---------- Link configs ---------------------------------------------------
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

link_config "$REPO_DIR/zshrc"          "$HOME/.zshrc"
link_config "$REPO_DIR/ghostty/config" "$HOME/.config/ghostty/config"

log "Done. Restart Ghostty and run: exec zsh"
