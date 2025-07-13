{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.browsers.zen;
in
{
  options.browsers.zen.enable = mkEnableOption "Enable Zen Browser";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ inputs.zen-browser.packages.${system}.default ];
    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true; # save webs for later reading
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
      };
    };
  };
}
