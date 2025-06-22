{
  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.brave
        ];

        xdg.mimeApps = {
          enable = true;
          # defaultApplications = {
          #   "text/html" = "brave-browser.desktop";
          #   "x-scheme-handler/http" = "brave-browser.desktop";
          #   "x-scheme-handler/https" = "brave-browser.desktop";
          # };
        };

        # Optional: Add a desktop shortcut
        programs.bash = {
          enable = true;
          shellAliases = {
            brave = "brave-browser";
          };
        };
      }
    )
  ];
}
