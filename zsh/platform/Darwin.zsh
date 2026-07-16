# macOS

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Standalone Neovim binary (remove if using brew install neovim)
export PATH="$HOME/bin/nvim-macos-arm64/bin:$PATH"
