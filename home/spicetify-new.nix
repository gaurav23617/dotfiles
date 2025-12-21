# Spicetify is a spotify client customizer
{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # Install Spotify on Linux via Nix
  # On macOS, Spotify is managed via Homebrew (see modules/darwin/homebrew.nix)
  # Don't include it in home.packages on macOS to avoid Nix build errors
  home.packages =
    if pkgs.stdenv.isLinux then
      [
        pkgs.spotify
        inputs.spicetify-nix.packages."${pkgs.stdenv.hostPlatform.system}".default
      ]
    else
      [ ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      # Only enable spicetify-nix on Linux where Spotify is installed via Nix
      # On macOS: Spotify installed via Homebrew, so use spicetify-cli via Homebrew instead
      # (spicetify-nix doesn't work with Homebrew-installed Spotify)
      enable = pkgs.stdenv.isLinux;
      theme = spicePkgs.themes.text;
      colorScheme = "TokyoNight";

      enabledExtensions = with spicePkgs.extensions; [
        # adblock
        shuffle # shuffle+ (special characters  sanitized out of ext names)
        keyboardShortcut # vimium-like navigation
        volumePercentage
      ];

      # Uncomment and customize as needed:
      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
        localFiles
        ncsVisualizer
        historyInSidebar
        betterLibrary
      ];
    };
}
