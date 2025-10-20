{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    bat
    ripgrep
    tldr
    sesh
    yq
    fd
    zoxide
    fzf
    eza
    bat
    carapace
    vivid
  ];

  programs.nushell = {
    enable = true;
    configFile.source = ../config/nushell/config.nu;
    envFile.source = ../config/nushell/env.nu;
    # loginFile.source = ./.config/nushell/login.nu;
  };
  home.file.".config/nushell" = {
    recursive = true;
    source = ../config/nushell;
  };
}
