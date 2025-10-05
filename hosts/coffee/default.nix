# hosts/darwin/coffee/default.nix
{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  # Set the primary user for system defaults
  system.primaryUser = "gaurav";

  # Allow unfree packages
  nixpkgs.config.allowBroken = true;

  nix = {
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Use optimise.automatic instead of auto-optimise-store
    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  # Packages available to all users.
  environment.systemPackages = with pkgs; [
    coreutils # Provides GNU core utilities
    wget # A classic command-line downloader
    btop
  ];

  # Integrates nix-homebrew to manage apps not in nixpkgs.
  nix-homebrew = {
    enable = true;
    user = "gaurav";
    autoMigrate = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
  };

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew"; # For Apple Silicon
    casks = [ "google-chrome" "spotify" "raycast" ];
  };

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.orientation = "left";
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  # This is required! Set it to the version of Nix-Darwin you're using.
  system.stateVersion = 4;
}
