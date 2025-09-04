{ ... }:

{
  home-manager.sharedModules = [
    ({ config, lib, pkgs, ... }: {
      programs.starship.enable = true;

      home.file.".config/starship.toml".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/NixOS/config/starship.toml";
    })
  ];
}
