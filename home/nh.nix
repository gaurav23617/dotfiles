{ config, homeDirectory ? config.home.homeDirectory, ... }: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "${homeDirectory}/dotfiles";
  };
}
