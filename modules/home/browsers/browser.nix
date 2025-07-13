{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  chromeCfg = config.browsers.chrome;
  braveCfg = config.browsers.brave;
in
{
  options.browsers = {
    chrome.enable = mkEnableOption "Enable Google Chrome browser";
    brave.enable = mkEnableOption "Enable Brave browser";
  };

  config = {
    # Google Chrome
    programs.chromium = mkIf chromeCfg.enable {
      enable = true;
      package = pkgs.google-chrome;
      # Optional: Uncomment to add extensions
      # extensions = [
      #   { id = "ficfmibkjjnpogdcfhfokmihanoldbfe"; } # File Icons for GitHub
      # ];
    };

    # Brave
    home.packages = mkIf braveCfg.enable [
      pkgs.brave
    ];

    xdg.mimeApps = mkIf braveCfg.enable {
      enable = true;
      # Optional default apps
      # defaultApplications = {
      #   "text/html" = "brave-browser.desktop";
      #   "x-scheme-handler/http" = "brave-browser.desktop";
      #   "x-scheme-handler/https" = "brave-browser.desktop";
      # };
    };

    programs.bash = mkIf braveCfg.enable {
      enable = true;
      shellAliases = {
        brave = "brave-browser";
      };
    };
  };
}
