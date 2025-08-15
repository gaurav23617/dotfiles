{
  home-manager.sharedModules = [
    ({ config, pkgs, lib, ... }: {
      programs.zsh = {
        enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
      };

      home.file.".config/zsh/.zshrc".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/NixOS/config/zsh/.zshrc";
    })
  ];
}
