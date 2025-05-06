{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

with lib;

{
  options.within.ghostty.enable = mkEnableOption "Enables ghostty Terminal Settings";

  config = mkIf config.within.ghostty.enable {
    nixpkgs = {
      overlays = [
        inputs.brew-nix.overlays.default
      ];
    };

    home.packages = [
      inputs.ghostty.packages."${pkgs.system}".default
    ];

    home.file = {
      ".config/ghostty/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/ghostty/config";
      };
    };
  };
}
