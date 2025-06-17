{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  home.packages = with pkgs; [
    diff-so-fancy
  ];

  home.file.".config/git/config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/git/.gitconfig";
}
