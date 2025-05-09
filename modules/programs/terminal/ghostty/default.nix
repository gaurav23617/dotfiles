{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

with lib;

{
  options.within.ghostty = {
    enable = mkEnableOption "Enable Ghostty Terminal";
  };

  config = mkIf config.within.ghostty.enable {
    environment.systemPackages = [
      inputs.ghostty.packages.${pkgs.system}.default
    ];

    home-manager.sharedModules = [
      (
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          programs.ghostty.enable = true;

          home.file.".config/ghostty/config" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/config/ghostty/config";
          };
        }
      )
    ];
  };
}
