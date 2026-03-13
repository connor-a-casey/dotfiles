#!/bin/bash
# Deploy dotfiles to a new Mac
# Run from the dotfiles directory: ./deploy.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "Deploying dotfiles from $DOTFILES_DIR"
echo ""

# Create .config if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Backup existing configs if they exist and aren't already symlinks
for name in nvim kitty; do
  target="$CONFIG_DIR/$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $name config to $backup"
    mv "$target" "$backup"
  fi
done

# Create symlinks
echo "Creating symlinks..."
ln -sfn "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
ln -sfn "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"

echo ""
echo "Done! Symlinks created:"
echo "  $CONFIG_DIR/nvim  -> $DOTFILES_DIR/nvim"
echo "  $CONFIG_DIR/kitty -> $DOTFILES_DIR/kitty"
echo ""
echo "Add to your ~/.zshrc (optional, for script paths):"
echo "  export DOTFILES=\"$DOTFILES_DIR\""
echo ""
echo "Restart Kitty and Neovim to use the new config."
