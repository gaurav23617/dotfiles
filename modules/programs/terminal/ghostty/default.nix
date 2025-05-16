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
    # System-level packages
    environment.systemPackages = [
      inputs.ghostty.packages.${pkgs.system}.default
    ];

    # Home-manager configuration using sharedModules approach
    home-manager.sharedModules = [
      (
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          programs.ghostty.enable = true;

          # Use mkOutOfStoreSymlink to create a symlink to the config file
          home.file.".config/ghostty/config".source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/ghostty/linux-config";
        }
      )
    ];
  };
}
