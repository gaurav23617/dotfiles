{ pkgs, ... }:
{
  programs.btop = {
    package = pkgs.btop-cuda;
    enable = true;
  };
  home.file.".config/btop" = {
    recursive = true;
    source = ../config/btop;
  };
}
