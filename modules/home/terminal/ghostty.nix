{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.terminal.ghostty;
  config_name = if pkgs.stdenv.isLinux then "linux-config" else "mac-config";
in
{
  options.terminal.ghostty.enable = mkEnableOption "Enables ghostty Terminal Settings";

  config = mkIf cfg.enable {

    nixpkgs = {
      overlays = [
        inputs.brew-nix.overlays.default
      ];
    };
    home.packages = (
      if pkgs.stdenv.isLinux then
        [
          inputs.ghostty.packages."${pkgs.system}".default
        ]
      else
        [ pkgs.brewCasks.ghostty ]
    );
    home.file = {
      ".config/ghostty/config" = {
        source = ../../../config/ghostty/common-config;
      };
      ".config/ghostty/${config_name}" = {
        source = ../../../config/ghostty/${config_name};
      };
    };
  };
}
