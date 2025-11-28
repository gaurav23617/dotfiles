{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
  };
  home.file.".config/zed".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zed"
  );
}
