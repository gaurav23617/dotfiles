{ inputs, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "spotify" ];

  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        # Only install actual programs here
        home.packages = with pkgs; [
          spotify
          spicetify-cli
        ];

        # Import Spicetify module
        imports = [ inputs.spicetify-nix.homeManagerModules.default ];

        # Use theme only inside spicetify config (no global install)
        programs.spicetify = {
          enable = true;
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
