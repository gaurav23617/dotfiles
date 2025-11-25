{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    ripgrep
    tldr
    sesh
    yq
    fd
    zoxide
    yazi
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

  home.file.".config/zsh".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink ../config/zsh
  );
}
