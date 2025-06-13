{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Simple options to enable/disable browsers
  options.browsers = {
    chrome.enable = lib.mkEnableOption "Google Chrome";
    brave.enable = lib.mkEnableOption "Brave Browser";
  };

  config = {
    # Chrome
    programs.chromium = lib.mkIf config.browsers.chrome.enable {
      enable = true;
      package = pkgs.google-chrome;
      extensions = [
        { id = "ficfmibkjjnpogdcfhfokmihanoldbfe"; } # File Icons for GitHub and GitLab
      ];
    };

    # Brave
    home.packages = lib.optional config.browsers.brave.enable pkgs.brave;

    xdg.mimeApps = lib.mkIf config.browsers.brave.enable {
      enable = true;
      defaultApplications = {
        "text/html" = "brave-browser.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
      };
    };

    # Optional: Add bash alias for Brave
    programs.bash = lib.mkIf config.browsers.brave.enable {
      enable = true;
      shellAliases = {
        brave = "brave-browser";
      };
    };
  };
}
