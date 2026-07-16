# Dotfiles

Neovim, Kitty, Zsh, and Tmux config — works on **macOS** and **Linux**.

Platform-specific settings live in `zsh/platform/` and `kitty/darwin.conf` / `kitty/linux.conf`. Shared config (Neovim plugins, tmux, synthwave84 theme) is the same on both.

## What's Included

| Path | macOS | Linux |
|------|-------|-------|
| **nvim/** | Neovim (lazy.nvim, LSP, keymaps) | Same |
| **kitty/** | `darwin.conf` — Cmd keybinds, blur, fullscreen | `linux.conf` — Ctrl+Shift+Alt keybinds, maximized |
| **zsh/** | Starship, Zoxide, Homebrew, standalone Neovim path | Starship, Zoxide, `~/.local/bin` |
| **tmux/** | Ctrl-a prefix, vi keys, synthwave84 colors | Same |

---

## macOS — New Machine

### Prerequisites

Install [Homebrew](https://brew.sh), then:

```bash
brew tap homebrew/cask-fonts
brew install neovim starship zoxide tmux
brew install --cask kitty font-jetbrains-mono-nerd-font
```

One-liner:

```bash
brew tap homebrew/cask-fonts && brew install neovim starship zoxide tmux && brew install --cask kitty font-jetbrains-mono-nerd-font
```

### Optional (match your current Mac)

| Tool | Your setup | New Mac option |
|------|------------|----------------|
| Neovim | `~/bin/nvim-macos-arm64/bin` on PATH | [Download release](https://github.com/neovim/neovim/releases) or `brew install neovim` and remove that line from `zsh/platform/Darwin.zsh` |
| NVM | `~/.nvm` | [nvm install script](https://github.com/nvm-sh/nvm) |
| Go | `~/go/bin` | `brew install go` |
| Julia | `~/.juliaup/bin` | [juliaup](https://github.com/JuliaLang/juliaup) |
| `~/.local/bin/env` | uv-style PATH hook | [uv](https://docs.astral.sh/uv/) or remove from `zsh/zshrc` |

### Deploy

```bash
cd ~/Documents/dotfiles   # or wherever you cloned the repo
chmod +x deploy.sh
./deploy.sh
```

---

## Linux — New Machine

### Prerequisites

**Debian / Ubuntu:**

```bash
sudo apt update
sudo apt install -y zsh tmux curl git

# Neovim (use your distro's package or install latest from GitHub)
sudo apt install -y neovim

# Kitty
sudo apt install -y kitty

# Starship
curl -sS https://starship.rs/install.sh | sh

# Zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# JetBrains Mono Nerd Font
mkdir -p ~/.local/share/fonts
curl -fLo /tmp/JetBrainsMono.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
```

**Fedora:**

```bash
sudo dnf install -y zsh tmux neovim kitty curl git
curl -sS https://starship.rs/install.sh | sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

**Arch:**

```bash
sudo pacman -S zsh tmux neovim kitty starship zoxide git
yay -S ttf-jetbrains-mono-nerd   # or from AUR
```

### Deploy

```bash
cd ~/dotfiles   # or wherever you cloned the repo
chmod +x deploy-linux.sh deploy.sh
./deploy-linux.sh
# or: ./deploy.sh   (auto-detects Linux)
```

### Linux notes

- Kitty uses **Ctrl+Shift+Alt** as the modifier (instead of Cmd+Option on Mac).
- Layouts: **Ctrl+Shift+Alt+U/F/O** = tall / fat / stack.
- Scrollback in nvim: **Ctrl+Shift+Alt+I** (Mac: Cmd+Option+I).
- Resize panes: **Ctrl+Shift+Alt+Shift+H/J/K/L**.
- New window/tab: **Ctrl+Shift+N** / **Ctrl+Shift+T**.
- Background blur is macOS-only and omitted on Linux.
- Install a Nerd Font and set it in your desktop environment if icons look wrong outside Kitty.

---

## Deploy (both platforms)

`deploy.sh` detects the OS and symlinks the right configs:

| Symlink | Target |
|---------|--------|
| `~/.config/nvim` | `nvim/` |
| `~/.config/kitty/kitty.conf` | `kitty/darwin.conf` or `kitty/linux.conf` |
| `~/.config/kitty/session.conf` | `kitty/session.darwin.conf` or `kitty/session.linux.conf` |
| `~/.config/kitty/themes`, `backgrounds`, `images` | shared asset dirs |
| `~/.zshrc` | `zsh/zshrc` (sources `zsh/platform/Darwin.zsh` or `Linux.zsh`) |
| `~/.zprofile` | `zsh/zprofile` |
| `~/.tmux.conf` | `tmux/tmux.conf` |

Existing real files (not symlinks) are backed up with a timestamp before overwriting.

## After Deploy

1. **New terminal** — Starship and Zoxide load from `~/.zshrc`.
2. **Restart Kitty** — Platform startup session runs automatically.
3. **Open Neovim** — lazy.nvim installs plugins on first launch.

### Kitty quick-access keybinds (macOS only)

`kitty/darwin.conf` references scripts under `~/github/dotfiles-latest/`. Those are not in this repo. Either symlink this repo there and add the scripts, or remove those `map kitty_mod+a>...` lines.

## Updating Configs

**macOS** — copy live config into the repo:

```bash
rsync -a --delete ~/.config/nvim/ ~/Documents/dotfiles/nvim/
rsync -a ~/.config/kitty/ ~/Documents/dotfiles/kitty/ --exclude='*.bak'
# Edit zsh/platform/Darwin.zsh for mac-only PATH changes
```

**Linux** — edit `zsh/platform/Linux.zsh`, `kitty/linux.conf`, or shared files directly.

If symlinked via `./deploy.sh`, edits in this repo apply immediately (restart Kitty for kitty.conf changes).

## Structure

```
dotfiles/
├── nvim/                         # shared
├── kitty/
│   ├── base.conf                 # shared theme, fonts, cursor
│   ├── darwin.conf               # macOS keybinds + blur
│   ├── linux.conf                # Linux keybinds
│   ├── session.darwin.conf
│   ├── session.linux.conf
│   ├── themes/
│   └── backgrounds/
├── zsh/
│   ├── zshrc                     # shared entry (sources platform file)
│   ├── zprofile
│   └── platform/
│       ├── Darwin.zsh            # Homebrew, standalone Neovim
│       ├── Darwin.zprofile
│       ├── Linux.zsh
│       └── Linux.zprofile
├── tmux/                         # shared
├── deploy.sh                     # macOS + Linux (auto-detect)
├── deploy-linux.sh               # Linux wrapper
└── README.md
```
