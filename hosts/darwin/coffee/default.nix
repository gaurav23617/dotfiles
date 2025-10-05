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
  ];

  # Install system-wide fonts.
  fonts.packages = with pkgs; [ fira-code fira-code-nerd-font ];

  # --- HOMEBREW SUPPORT (for GUI Apps & Casks) ---
  # Integrates nix-homebrew to manage apps not in nixpkgs.
  nix-homebrew = {
    enable = true;
    # Your username must match the one above.
    user = "gaurav";
    # Automatically update Homebrew taps.
    autoMigrate = true;
    # Where to install Homebrew packages.
    brewPrefix = "/opt/homebrew"; # For Apple Silicon
    # Taps you want to use.
    taps = {
      "homebrew/homebrew-core" = config.inputs.nix-homebrew.homebrew-core;
      "homebrew/homebrew-cask" = config.inputs.nix-homebrew.homebrew-cask;
    };
    # Install GUI applications (Casks).
    casks = [ "google-chrome" "spotify" ];
  };

  # A few examples of how to configure macOS declaratively.
  system.settings = {
    # Set dark mode.
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    # Put the Dock on the left side of the screen.
    dock.orientation = "left";
  };

  # This is required! Set it to the version of Nix-Darwin you're using.
  system.stateVersion = 4;
}
