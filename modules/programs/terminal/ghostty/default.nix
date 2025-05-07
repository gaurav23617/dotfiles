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
    # System-level install
    environment.systemPackages = [
      inputs.ghostty.packages.${pkgs.system}.default
    ];

    # Home-manager config symlink for ~/.config/ghostty/config
    home-manager.sharedModules = [
      # your existing modules like zsh...
      (
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          programs.ghostty.enable = true;

          home.file.".config/ghostty/config".source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/config/ghostty/config";
        }
      )
    ];
  };
}
