# hosts/darwin/coffee/default.nix
{ config, pkgs, inputs, ... }:

{
  imports =
    [ inputs.nix-homebrew.darwinModules.nix-homebrew ../../../modules/common ];

  # Packages available to all users.
  environment.systemPackages = with pkgs; [
    coreutils # Provides GNU core utilities
    wget # A classic command-line downloader
    btop
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
