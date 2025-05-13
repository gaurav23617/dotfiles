{
  home-manager.sharedModules = [
    (
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        programs.git.enable = true;

        home.file.".gitconfig".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOs/config/git/.gitconfig";

        home.file.".config/git/template".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOs/config/git/template";
      }
    )
  ];
}
