{
  pkgs,
  lib,
  config,
  ...
}: {
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
    initContent = builtins.readFile ../config/zsh/.zshrc;
  };

  # home.file.".config/zsh" = {
  #   recursive = true;
  #   source = ../config/zsh;
  # };

  # home.file.".config/zsh".source = builtins.toString (
  #   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zsh"
  # );

  home.file.".config/zsh".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink ../config/zsh
  );
}
