# Linux

# Homebrew on Linux (optional)
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# User-local binaries (apt, pipx, uv, etc.)
export PATH="$HOME/.local/bin:$PATH"
