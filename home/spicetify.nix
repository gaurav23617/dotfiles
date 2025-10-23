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

  # Only install Spotify on Linux, use Homebrew on macOS
  home.packages = lib.optionals pkgs.stdenv.isLinux [
    pkgs.spotify
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;

      # On macOS, spicetify will automatically detect Homebrew Spotify
      # Don't set spotifyPackage on macOS, let it auto-detect
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        # adblock
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        keyboardShortcut # vimium-like navigation
        copyLyrics # copy lyrics with selection
      ];

      # Uncomment and customize as needed:
      # enabledCustomApps = with spicePkgs.apps; [
      #   lyricsPlus
      #   marketplace
      #   localFiles
      #   ncsVisualizer
      # ];
    };
}
