# hosts/darwin/coffee/default.nix
{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  ids.gids.nixbld = 350;

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

    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [ coreutils wget btop ];

  environment = {
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  environment.variables = {
    HOMEBREW_PREFIX = "/opt/homebrew";
    HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
    HOMEBREW_REPOSITORY = "/opt/homebrew";
  };

  # This installs Homebrew via nix-homebrew
  nix-homebrew = {
    enable = true;
    user = "gaurav";
    enableRosetta = true;
    autoMigrate = false;

    # Key: install Homebrew if not present
    # This will happen BEFORE the homebrew module tries to run
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
  };

  # Configure what to install via Homebrew
  homebrew = {
    enable = true;

    # Only enable if brew is already installed
    # This prevents the error on first run
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [ "homebrew/core" "homebrew/cask" ];

    casks = [ "google-chrome" "spotify" "raycast" ];

    brews = [ ];
    masApps = { };
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

  system.stateVersion = 4;
}
