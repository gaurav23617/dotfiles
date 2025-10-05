{ pkgs, lib, config, ... }: {
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

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ../config/zsh/.zshrc;
  };

  home.file.".config/zsh" = {
    recursive = true;
    source = ../config/zsh;
  };
}
