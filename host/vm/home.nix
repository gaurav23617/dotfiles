# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    ../../users/gaurav.nix
    ../../modules/home-manager
    ../../modules/home-manager/cli/git.nix
    ../../modules/home-manager/shell/zsh.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  browsers = {
    zen.enable = true; # Set to false to disable
    chrome.enable = false; # Set to false to disable
    brave.enable = false; # Set to false to disable
  };

  cli = {
    direnv.enable = true;
    nh.enable = true;
    gh.enable = true;
    starship.enable = true;
  };

  editor = {
    neovim.enable = true;
    vscode.enable = false;
  };

  misc = {
    lact.enable = true; # Set to false to disable
    cpufreq.enable = true; # Set to false to disable
    nix-ld.enable = true; # Set to false to disable
    thunar.enable = true; # Set to false to disable
    tlp.enable = true; # Set to false to disable
  };

  terminal = {
    ghostty.enable = false; # Set to false to disable
    kitty.enable = true; # Set to false to disable
  };

  # Host-specific packages and config
  home.packages = with pkgs; [
    fzf
    fd
    git
    gh
    vlc
    diff-so-fancy
    eza
    nodejs_22
    nix-prefetch-scripts
    ripgrep
    zoxide
    bash
    tldr
    unzip
    (pkgs.writeShellScriptBin "hello" ''
      echo "Hello ${username}!"
    '')
  ];

  # Enable dconf for home-manager
  programs.dconf.enable = true;

  systemd.user.startServices = "sd-switch";
}
