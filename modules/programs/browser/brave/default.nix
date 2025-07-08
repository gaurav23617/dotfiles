{
  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.brave
        ];
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
