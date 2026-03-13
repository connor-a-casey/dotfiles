# Dotfiles

Neovim config as well as Kitty which can be replicated on any Mac. 

## What's Included

- **nvim/** — Neovim config (init.lua, plugins, keymaps, LSP, etc.)
- **kitty/** — Kitty terminal config (theme, keybinds, synthwave84)

## Prerequisites (New Mac)

Install these before or after deploying:

1. **Homebrew** — [brew.sh](https://brew.sh)
2. **Neovim** — `brew install neovim`
3. **Kitty** — `brew install --cask kitty`
4. **JetBrains Mono Nerd Font** — `brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font`

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

- Create `~/.config/nvim` and `~/.config/kitty` as symlinks to this repo
- Back up any existing configs (with a timestamp) before overwriting

## After Deploy

1. **Restart Kitty** — Quit and reopen Kitty (or run `kitty @ set-config reload=true`).
2. **Open Neovim** — Run `nvim`; it will install plugins via lazy.nvim on first launch.
3. **Optional:** Add to `~/.zshrc` if you use the optional Kitty scripts:
   ```bash
   export DOTFILES="$HOME/Documents/dotfiles"
   ```

## Updating Configs

Edit files in this repo. Changes apply immediately since the configs are symlinked.

## Syncing to a New Mac

1. Copy this folder to the new Mac (git clone, USB, iCloud, etc.).
2. Install prerequisites (Homebrew, Neovim, Kitty, Nerd Font).
3. Run `./deploy.sh`.
4. Restart Kitty and open Neovim.

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
│   ├── themes/
│   │   └── synthwave84.conf
│   └── backgrounds/
│       └── synthwave84-bg.png
├── deploy.sh
└── README.md
```
