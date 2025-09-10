{config, ...}: let
  inherit (config.var) username;
in {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "/home/${username}/dotfiles";
  };
}
