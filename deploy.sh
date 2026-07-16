#!/bin/bash
# Deploy dotfiles on macOS or Linux
# Run from the dotfiles directory: ./deploy.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
OS="$(uname -s)"

case "$OS" in
  Darwin)
    PLATFORM="darwin"
    KITTY_CONF="darwin.conf"
    KITTY_SESSION="session.darwin.conf"
    ;;
  Linux)
    PLATFORM="linux"
    KITTY_CONF="linux.conf"
    KITTY_SESSION="session.linux.conf"
    ;;
  *)
    echo "Unsupported OS: $OS (expected Darwin or Linux)"
    exit 1
    ;;
esac

echo "Deploying dotfiles from $DOTFILES_DIR ($PLATFORM)"
echo ""

mkdir -p "$CONFIG_DIR"

# Migrate legacy deploy that symlinked the entire kitty directory
if [[ -L "$CONFIG_DIR/kitty" ]]; then
  legacy_target="$(readlink "$CONFIG_DIR/kitty" || true)"
  if [[ "$legacy_target" == "$DOTFILES_DIR/kitty" ]]; then
    echo "Migrating legacy kitty directory symlink..."
    rm "$CONFIG_DIR/kitty"
  fi
fi

backup_if_real() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $(basename "$target") to $backup"
    mv "$target" "$backup"
  fi
}

# Backup existing nvim if it's a real directory (not a symlink to this repo)
backup_if_real "$CONFIG_DIR/nvim"

# Backup and symlink home dotfiles (zsh, tmux)
for pair in "zsh/zshrc:.zshrc" "zsh/zprofile:.zprofile" "tmux/tmux.conf:.tmux.conf"; do
  src="${pair%%:*}"
  dest="${pair##*:}"
  target="$HOME/$dest"
  backup_if_real "$target"
  if [[ -f "$DOTFILES_DIR/$src" ]]; then
    ln -sfn "$DOTFILES_DIR/$src" "$target"
    echo "Linked $dest"
  fi
done

# Neovim: single directory symlink
echo "Creating symlinks..."
ln -sfn "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# Kitty: symlink assets + platform-specific config files
mkdir -p "$CONFIG_DIR/kitty"
for dir in themes backgrounds images; do
  if [[ -d "$DOTFILES_DIR/kitty/$dir" ]]; then
    backup_if_real "$CONFIG_DIR/kitty/$dir"
    ln -sfn "$DOTFILES_DIR/kitty/$dir" "$CONFIG_DIR/kitty/$dir"
  fi
done

backup_if_real "$CONFIG_DIR/kitty/kitty.conf"
backup_if_real "$CONFIG_DIR/kitty/session.conf"
ln -sfn "$DOTFILES_DIR/kitty/$KITTY_CONF" "$CONFIG_DIR/kitty/kitty.conf"
ln -sfn "$DOTFILES_DIR/kitty/$KITTY_SESSION" "$CONFIG_DIR/kitty/session.conf"

echo ""
echo "Done! Symlinks created:"
echo "  $CONFIG_DIR/nvim         -> $DOTFILES_DIR/nvim"
echo "  $CONFIG_DIR/kitty/kitty.conf -> $DOTFILES_DIR/kitty/$KITTY_CONF"
echo "  $CONFIG_DIR/kitty/session.conf -> $DOTFILES_DIR/kitty/$KITTY_SESSION"
echo "  $HOME/.zshrc             -> $DOTFILES_DIR/zsh/zshrc"
echo "  $HOME/.zprofile          -> $DOTFILES_DIR/zsh/zprofile"
echo "  $HOME/.tmux.conf         -> $DOTFILES_DIR/tmux/tmux.conf"
echo ""
echo "Restart Kitty, Neovim, and open a new terminal to use the new config."
