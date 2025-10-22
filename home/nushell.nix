{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    # Core utilities
    bat
    eza
    fd
    fzf
    ripgrep

    # Shell enhancements
    atuin
    carapace
    starship
    zoxide

    # Other tools
    lazygit
    sesh
    tldr
    vivid
    yq
  ];

  programs.nushell = {
    enable = true;
    configFile.source = ../config/nushell/config.nu;
    envFile.source = ../config/nushell/env.nu;
  };

  home.file.".config/nushell" = {
    recursive = true;
    source = ../config/nushell;
  };
}
