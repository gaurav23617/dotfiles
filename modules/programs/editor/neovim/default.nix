{ ... }:
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
        programs.neovim = {
          enable = true;
          vimAlias = true;
          vimdiffAlias = true;
        };

        home.file.".config/nvim".source = builtins.toString (
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim"
        );
      }
    )
  ];
}
