{
  config,
  lib,
  pkgs,
  ...
}:

{
  home-manager.sharedModules = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs.zsh.enable = true;
        programs.zsh.dotDir = ".config/zsh"; # Link your .zshrc in the config folder

        # Link the .zshrc file
        home.file.".config/zsh".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/config/zsh";
      }
    )
  ];
}
