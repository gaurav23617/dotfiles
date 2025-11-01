{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    autoraise
  ];
  programs.aerospace = {
    enable = true;
    userSettings = pkgs.lib.importTOML ../config/aerospace/aerospace.toml;
  };
  # home.file.".config/aerospace/aerospace.toml" = {
  #   source = ../config/aerospace/aerospace.toml;
  # };
}
