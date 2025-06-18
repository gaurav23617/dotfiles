{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.home-manager.cli.direnv;
in
{
  options.home-manager.cli.direnv.enable =
    mkEnableOption "Enable direnv with nix-direnv and shell integrations";

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

    # Optional: Uncomment if you want custom cache paths
    # home.sessionVariables = {
    #   DIRENV_DIR = "/tmp/direnv";
    #   DIRENV_CACHE = "/tmp/direnv-cache";
    # };
  };
}
