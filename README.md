# Dotfiles

Neovim, Kitty, Zsh, and Tmux config — deployable on any Mac.

## What's Included

- **nvim/** — Neovim config (init.lua, plugins, keymaps, LSP, etc.)
- **kitty/** — Kitty terminal config (theme, keybinds, synthwave84)
- **zsh/** — Zsh config with Starship prompt + Zoxide (smarter `cd`)
- **tmux/** — Tmux config (vi keys, Ctrl-a prefix, synthwave84 colors)

## Prerequisites (New Mac)

Install these before or after deploying:

```bash
# Core
brew install neovim
brew install --cask kitty

# Shell & terminal
brew install zsh starship zoxide tmux

# Font (required for Nerd icons in Kitty & Neovim)
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

One-liner:
```bash
brew tap homebrew/cask-fonts && brew install neovim starship zoxide tmux && brew install --cask kitty font-jetbrains-mono-nerd-font
```

## Deploy

### Option 1: Clone and deploy

```bash
# Clone this repo (or copy the folder)
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Run the deploy script
chmod +x deploy.sh
./deploy.sh
```

### Option 2: Copy folder and deploy

```bash
# Copy the dotfiles folder to your new Mac (USB, cloud, etc.)
cd ~/Documents/dotfiles   # or wherever you put it

chmod +x deploy.sh
./deploy.sh
```

The script will:

- Create symlinks: `~/.config/nvim`, `~/.config/kitty`, `~/.zshrc`, `~/.zprofile`, `~/.tmux.conf`
- Back up any existing configs (with a timestamp) before overwriting

## After Deploy

1. **Restart Kitty** — Quit and reopen Kitty (or run `kitty @ set-config reload=true`).
2. **Open Neovim** — Run `nvim`; it will install plugins via lazy.nvim on first launch.
3. **Quick-access scripts:** Kitty keybinds (`kitty_mod+a>d`, etc.) use `~/github/dotfiles-latest`. On a new Mac, either clone this repo there, or symlink: `ln -sf ~/Documents/dotfiles ~/github/dotfiles-latest` (you’ll need the scripts/ and quick-access-terminal configs from your old setup).

## Updating Configs

Edit files in this repo. Changes apply immediately since the configs are symlinked.

## Syncing to a New Mac

1. Copy this folder to the new Mac (git clone, USB, iCloud, etc.).
2. Install prerequisites (see above).
3. Run `./deploy.sh`.
4. Open a new terminal; restart Kitty; run `nvim` to install plugins.

## Structure

```
dotfiles/
├── nvim/
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lua/
│   │   ├── connor/          # Core config, plugins, keymaps
│   │   └── current-theme.lua
│   └── after/ftplugin/      # File-type specific settings
├── kitty/
│   ├── kitty.conf
│   ├── session.conf         # startup session (fullscreen, etc.)
│   ├── themes/
│   │   └── synthwave84.conf
│   └── backgrounds/
│       └── synthwave84-bg.png
├── zsh/
│   ├── zshrc                # → ~/.zshrc (Starship, Zoxide, NVM, etc.)
│   └── zprofile             # → ~/.zprofile
├── tmux/
│   └── tmux.conf            # → ~/.tmux.conf
├── deploy.sh
└── README.md
```
