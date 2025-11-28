{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.lazygit.enable = true;
  home.file.".config/lazygit/config.yml" = {
    source = ../config/lazygit/config.yml;
  };
}
