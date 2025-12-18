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

  # Spicetify-nix will install Spotify automatically on all platforms
  home.packages = [ ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
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
