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
        programs.zsh.dotDir = ".config/zsh"; # Ensures .zshrc and other config files are in this folder

        # Correctly symlink .zshrc file
        home.file.".config/zsh/".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/config/zsh/";

        # Correctly symlink .zshenv if required
        home.file.".config/zsh/.zshenv".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/config/zsh/.zshenv";

      }
    )
  ];
}
