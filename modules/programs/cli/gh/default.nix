{ config, lib, pkgs, ... }: {
  home-manager.sharedModules = [
    (_: {
      programs.gh = {
        enable = true;
        # settings = {
        #   aliases = {
        #     co = "pr checkout";
        #     pv = "pr view";
        #   };
        # };
        extensions = pkgs [ dash ];
      };
    })
  ];
}
