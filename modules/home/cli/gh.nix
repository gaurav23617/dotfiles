{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.cli.gh;
in
{
  options.cli.gh.enable = mkEnableOption "Enable direnv with nix-direnv and shell integrations";

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
      # settings = {
      #   aliases = {
      #     co = "pr checkout";
      #     pv = "pr view";
      #   };
      # };
      extensions = pkgs [
        dash
      ];
    };
  };
}
