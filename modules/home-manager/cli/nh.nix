{ config, lib, ... }:

with lib;

let
  cfg = config.cli.direnv;
in
{
  options.cli.direnv.enable = mkEnableOption "Enable direnv and nix-direnv support";

  config = mkIf cfg.enable {
    environment.variables."DIRENV_WARN_TIMEOUT" = "60s";

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    # Optional:
    # home.sessionVariables = {
    #   DIRENV_DIR = "/tmp/direnv";
    #   DIRENV_CACHE = "/tmp/direnv-cache";
    # };
  };
}
