{
  config,
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "${config.home.homeDirectory}/dotfiles";
  };
}
