# Installation

This document contains platform-specific installation instructions for using these dotfiles.
We keep platform-specific commands separated to avoid confusion.

> **Note:** these instructions assume you have `git` and basic system tools installed. Nix is required for most setups.

---

## Quick clone

```bash
git clone --recurse-submodules https://github.com/gaurav23617/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

---

## Nix (common notes)

These dotfiles are managed as a Nix flake. Some example commands below use the **experimental** flakes option (if your Nix is older / flakes disabled, enable flakes first — see your distro docs).

If you have Nix with flakes enabled, you can use `--impure` or `--extra-experimental-features` depending on your system. Example (modern Nix):

```bash
# example: set NIX_CONFIG for experimental features (ad-hoc)
NIX_CONFIG="experimental-features = nix-command flakes" nix build .#homeConfigurations.gaura v
```

Below are example commands for macOS (darwin) and Linux (NixOS). Tweak host names (`atlas`, `coffee`, `hades`) to match your setup.

---

## Linux (NixOS)

### Full NixOS system (as root)

```bash
# Example: build and switch to the 'atlas' host configuration as root
sudo nixos-rebuild switch --flake .#atlas
```

### Home Manager only

```bash
# Home Manager switch for a specific host user/host
home-manager switch --flake .#gaurav@atlas
```

### Experimental flakes usage (if you rely on experimental features)

If your nix is configured without flakes globally, you can run:

```bash
# Example for ad-hoc enabling (bash/zsh)
NIX_CONFIG="experimental-features = nix-command flakes" home-manager switch --flake .#gaurav@atlas
```

or, if you prefer to use the nix CLI:

```bash
nix --extra-experimental-features 'nix-command flakes' build .#whatever
```

---

## macOS (Darwin)

### Full Darwin rebuild

```bash
# Build and switch to the 'coffee' host configuration
darwin-rebuild switch --flake .#coffee
```

### Home Manager only

```bash
home-manager switch --flake .#gaurav@coffee
```

### Experimental flakes usage on macOS

```bash
# ad-hoc enabling of flakes if your Nix isn't globally configured
NIX_CONFIG="experimental-features = nix-command flakes" darwin-rebuild switch --flake .#coffee
```

---

## Post-install

1. Make sure to configure your `git` user details in `config/git/config` or via `git config --global`.
2. Ensure you have your `sops/age` keys (see `docs/secrets.md`) for encrypted secrets to be usable by `sops-nix`.
3. After switching, run `home-manager switch` for user-level changes if needed.

---

## Troubleshooting & tips

- If flakes commands fail, ensure your Nix is up-to-date and `nix-command` + `flakes` are enabled either in `/etc/nix/nix.conf` or via `NIX_CONFIG` env.
- For debugging: use `nix build` on the flake outputs to see build errors before switching.
- For flake references across machines, you can use the flake URL `github:gaurav23617/dotfiles` or pin a flake lock.
