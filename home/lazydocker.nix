{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.lazydocker = {
    enable = true;
  };
}
