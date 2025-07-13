{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.cli.starship;
in

{
  options.cli.starship.enable = mkEnableOption "Enable Starship CLI Prompt";
  config = mkIf cfg.enable {
    programs.starship.enable = true;

    home.file.".config/starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/starship.toml";
  };
}
