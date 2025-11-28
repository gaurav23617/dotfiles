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

... (keep the existing lists from your README: Editors, Shell & CLI, Development Tools, Applications, Theme, Structure, Key Features, Key Bindings, Customization, Notes, Credits, License) ...

---

## 📚 Documentation

Installation steps and secret-handling have moved out of this README into `docs/`:

- `docs/installation.md` — platform-specific installation steps (macOS & Linux), including the Nix _experimental_ flakes command examples.
- `docs/secrets.md` — SOPS `age` key setup and how secrets are handled (sops-nix usage, where to store keys, example encrypt/decrypt commands).

If you want, I can also create a short `CONTRIBUTING.md` later explaining how to add new hosts or packages.

---
