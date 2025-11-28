# Dotfiles

My personal dotfiles managed with Nix flakes, featuring configurations for development tools, window managers, and shell environments across macOS and Linux.

## 📸 Preview

![Neovim Configuration](https://raw.githubusercontent.com/gaurav23617/dump/refs/heads/main/dotfiles/nvim-config-preview.webp)

## 🖥️ System Configuration

### 🐧 Linux (NixOS)
- **Window Manager**: [Hyprland](https://hyprland.org/) (Wayland compositor)
- **Bar**: Waybar with custom styling
- **Terminal**: [Ghostty](https://ghostty.org/)
- **Hosts**:
  - `atlas` - Main desktop workstation
  - `hades` - Server configuration

### 🍎 macOS (Darwin)
- **Window Manager**: [AeroSpace](https://github.com/nikitabobko/AeroSpace) (tiling WM)
- **Terminal**: Ghostty
- **Package Manager**: Homebrew (managed via Nix)
- **Hosts**:
  - `coffee` - MacBook configuration

## 🛠️ Core Tools

### Editors
- **[Neovim](https://neovim.io/)** - Primary text editor with extensive plugin setup
- **[Zed](https://zed.dev/)** - Modern code editor
- **[VSCode](https://code.visualstudio.com/)** - Occasional use

### Shell & CLI
- **Shell**: [Zsh](https://www.zsh.org/) with custom configuration
- **Prompt**: [Starship](https://starship.rs/)
- **Terminal Multiplexer**: [tmux](https://github.com/tmux/tmux) with custom status bar
- **File Navigation**: 
  - [zoxide](https://github.com/ajeetdsouza/zoxide) - Smart directory jumping
  - [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
  - [eza](https://github.com/eza-community/eza) - Modern `ls` replacement
- **File Manager**: [Yazi](https://github.com/sxyazi/yazi) / Thunar (GUI)
- **Shell History**: [Atuin](https://github.com/atuinsh/atuin)

### Development Tools
- **Git UI**: [lazygit](https://github.com/jesseduffield/lazygit)
- **Docker UI**: [lazydocker](https://github.com/jesseduffield/lazydocker)
- **System Monitor**: [btop](https://github.com/aristocratos/btop)
- **File Search**: [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd)
- **Cat Alternative**: [bat](https://github.com/sharkdp/bat) with Catppuccin theme
- **Session Manager**: [sesh](https://github.com/joshmedeski/sesh)
- **Environment Manager**: [direnv](https://direnv.net/)

### Applications
- **Browser**: [Zen Browser](https://zen-browser.app/) (Firefox-based)
- **Music**: Spotify with [Spicetify](https://spicetify.app/)
- **Launcher**: [Vicinae](https://github.com/vicinaehq/vicinae) (Linux)

## 🎨 Theme

Using **[Catppuccin Mocha](https://github.com/catppuccin/catppuccin)** color scheme across all applications for a consistent look.

## 📁 Structure

```
.
├── config/              # Application configurations
│   ├── aerospace/       # AeroSpace window manager (macOS)
│   ├── bat/            # Bat pager config
│   ├── btop/           # System monitor config
│   ├── ghostty/        # Terminal config
│   ├── git/            # Git configuration
│   ├── hypr/           # Hyprland config (Linux)
│   ├── nvim/           # Neovim configuration (submodule)
│   ├── tmux/           # Tmux configuration
│   ├── waybar/         # Status bar config (Linux)
│   ├── zed/            # Zed editor config
│   └── zsh/            # Zsh shell config
├── home/               # Home Manager modules
│   ├── editor/         # Editor configurations
│   ├── hyprland/       # Hyprland home config
│   ├── waybar/         # Waybar config
│   └── *.nix          # Individual tool configs
├── hosts/              # Host-specific configurations
│   ├── atlas/          # Linux desktop
│   ├── coffee/         # macOS laptop
│   └── hades/          # Linux server
├── modules/            # Nix modules
│   ├── darwin/         # macOS-specific
│   ├── nixos/          # Linux-specific
│   └── common/         # Shared configs
└── flake.nix          # Main Nix flake configuration
```

## 🚀 Installation

### Prerequisites

- **NixOS/Linux**: Install NixOS with flakes enabled
- **macOS**: Install [Nix package manager](https://nixos.org/download.html)

### Clone Repository

```bash
git clone --recurse-submodules https://github.com/gaurav23617/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### NixOS Installation

```bash
# Build and switch to configuration
sudo nixos-rebuild switch --flake .#atlas  # or .#hades

# For home-manager only
home-manager switch --flake .#gaurav@atlas
```

### macOS Installation

```bash
# Build and switch to Darwin configuration
darwin-rebuild switch --flake .#coffee

# For home-manager only
home-manager switch --flake .#gaurav@coffee
```

### First Time Setup

1. **SSH Keys**: Configure SOPS age key for secrets
   ```bash
   mkdir -p ~/.config/sops/age
   # Add your age key to ~/.config/sops/age/keys.txt
   ```

2. **Git Configuration**: Update git config with your details
   ```bash
   # Edit config/git/config with your information
   ```

3. **Secrets**: Decrypt secrets (SSH keys, etc.)
   ```bash
   # Secrets are automatically decrypted via sops-nix
   ```

## 🔑 Key Features

### Hyprland (Linux)
- Dynamic tiling with custom animations
- Catppuccin Mocha theme
- Waybar status bar with custom widgets
- Hardware acceleration with NVIDIA/AMD support
- SwayOSD for volume/brightness overlays
- SwayNC notification center

### AeroSpace (macOS)
- Vim-like keybindings
- Multi-monitor support
- Window padding and gaps
- Custom workspace layouts

### Tmux
- Custom status bar with git integration
- Window/pane icons based on running process
- Catppuccin theme
- Session management with sesh
- Vim-tmux-navigator integration

### Neovim
- Full IDE setup (see [nvim submodule](https://github.com/gaurav23617/nvim))
- LSP, treesitter, autocompletion
- Custom keymaps and plugins

## ⌨️ Key Bindings

### Hyprland (Linux)
- `Super + Return` - Open terminal
- `Super + Space` - Launch Vicinae
- `Super + Q` - Close window
- `Super + F` - Fullscreen toggle
- `Super + [1-9]` - Switch workspace
- `Super + Shift + [1-9]` - Move window to workspace

### AeroSpace (macOS)
- `Alt + H/J/K/L` - Focus window
- `Alt + Shift + H/J/K/L` - Move window
- `Alt + [1-9]` - Switch workspace
- `Alt + Shift + [1-9]` - Move to workspace

### Tmux
- `Ctrl + A` - Prefix key
- `Prefix + v` - Vertical split
- `Prefix + h` - Horizontal split
- `Ctrl + H/J/K/L` - Navigate panes (vim-style)

## 🔧 Customization

### Adding New Hosts

1. Create host directory: `hosts/{darwin|nixos}/hostname/`
2. Add `default.nix` and `home.nix`
3. Add to `flake.nix` outputs

### Modifying Themes

Theme files are located in:
- `config/*/catppuccin*.{yml,toml,css,nix}`
- Colors can be customized via Catppuccin variants (Mocha, Macchiato, Frappé, Latte)

### Adding Applications

1. Add package to appropriate `home/*.nix` or `modules/*/packages.nix`
2. Create config in `home/` if needed
3. Import in `hosts/*/home.nix`

## 📝 Notes

- **Secrets Management**: Using [sops-nix](https://github.com/Mic92/sops-nix) with age encryption
- **Neovim Config**: Maintained as separate submodule
- **Auto-login**: Enabled on `atlas` (disable for security)
- **NVIDIA**: Custom configuration for hybrid graphics laptops

## 🤝 Credits

Inspired by countless dotfiles repositories in the Nix community. Special thanks to:
- [Catppuccin](https://github.com/catppuccin/catppuccin) for the beautiful theme
- The Hyprland community
- NixOS and Home Manager maintainers

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

**Note**: This is a personal configuration. You may need to adjust hardware-specific settings, especially for NVIDIA GPU configurations and disk layouts.
