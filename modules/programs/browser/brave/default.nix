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
          defaultApplications = {
            "text/html" = "brave-browser.desktop";
            "x-scheme-handler/http" = "brave-browser.desktop";
            "x-scheme-handler/https" = "brave-browser.desktop";
          };
        };
        # Brave managed policies: force-install extensions, set homepage
        environment.etc."opt/brave/policies/managed/managed_policies.json".text = builtins.toJSON {
          ExtensionInstallForcelist = [
            "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
            "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          ];
          RestoreOnStartup = 4;
          HomepageLocation = "https://startpage.com";
          DefaultBrowserSettingEnabled = true;
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
