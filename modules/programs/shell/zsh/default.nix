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
          # Other Zsh options like history, aliases, initContent, etc...
        };

        # Symlink your Zsh folder (e.g. contains .zshrc, .p10k.zsh, etc.)
        home.file.".config/zsh/.zshrc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh/.zshrc";

        # DO NOT SYMLINK `.zshenv` ANYWHERE — let Home Manager manage /etc/zshenv
      }
    )
  ];
}
