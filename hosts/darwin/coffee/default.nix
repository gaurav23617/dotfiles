# hosts/darwin/my-macbook/default.nix
{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
  # Enable flakes and the new command-line interface.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Automatically run the garbage collector to free up disk space.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  # Packages available to all users.
  environment.systemPackages = with pkgs; [
    coreutils # Provides GNU core utilities
    wget # A classic command-line downloader
    btop
    raycast
  ];

  # Install system-wide fonts.
  fonts.packages = with pkgs; [ fira-code fira-code-nerd-font ];

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
    casks = [ "google-chrome" "spotify" ];
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
