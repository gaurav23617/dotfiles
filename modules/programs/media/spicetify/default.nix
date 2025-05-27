{ inputs, lib, ... }:

{
  # Allow unfree packages like Spotify
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "spotify" ];

  home-manager.sharedModules = [
    (
      { pkgs, ... }:

      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in

      {
        # Install only actual binaries
        home.packages = with pkgs; [
          spotify
          spicetify-cli
        ];

        # Import spicetify-nix module
        imports = [
          inputs.spicetify-nix.homeManagerModules.default
        ];

        # Configure spicetify, safely referencing theme
        programs.spicetify = {
          enable = true;

          # Reference theme only inside Spicetify config (do not install globally)
          theme = spicePkgs.themes.catppuccin;
          colorScheme = "mocha";

          enabledExtensions = with spicePkgs.extensions; [
            shuffle
            keyboardShortcut
            copyLyrics
            fullAppDisplay
          ];

          enabledCustomApps = with spicePkgs.apps; [
            marketplace
            localFiles
          ];
        };
      }
    )
  ];
}
