{ config, lib, pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ../config/starship.toml;
  };
  # home.file.".config/starship.toml" = { source = ../config/starship.toml; };
}
