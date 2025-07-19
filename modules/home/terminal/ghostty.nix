{
  lib,
  config,
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
    # Use ghostty from nixpkgs (simpler approach)
    home.packages = [ pkgs.ghostty ];

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
