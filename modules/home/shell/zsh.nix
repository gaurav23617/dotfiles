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
        programs.zsh = {
          enable = true;
          dotDir = ".config/zsh";
        };

        home.file.".config/zsh/.zshrc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh/.zshrc";
      }
    )
  ];
}
