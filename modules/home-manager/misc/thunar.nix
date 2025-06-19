{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.misc.thunar;
in
{
  options.misc.thunar.enable = mkEnableOption "Thunar file manager";
  config = mkIf cfg.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin # Archive management
        thunar-volman # Volume management (automount removable devices)
        thunar-media-tags-plugin # Tagging & renaming feature for media files
      ];
    };
    # Archive manager
    programs.file-roller = {
      enable = true;
      package = pkgs.file-roller;
    };
    services.tumbler.enable = true; # Thumbnail support for images
  };
}
