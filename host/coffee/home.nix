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
    ../../modules/home-manager/browsers/zen.nix
    ../../modules/home-manager/browsers/browser.nix
    ../../modules/home-manager/editor/neovim.nix
    ../../modules/home-manager/editor/vscode.nix
    ../../modiles/home-manager/git.nix
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
    chrome.enable = true; # Set to false to disable
    brave.enable = false; # Set to false to disable
  };

  # Host-specific packages and config
  home.packages = with pkgs; [
    # Packages specific to this machine
  ];

  systemd.user.startServices = "sd-switch";
}
