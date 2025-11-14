{
  config,
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ../../home/nh.nix
    ../../home/git.nix
    ../../home/lazydocker.nix
    ../../home/gh.nix
  ];

  home.username = "hades";
  home.homeDirectory = "/home/hades";

  home.packages = [];
  home.file = {};
  xdg.userDirs = {
    enable = true;
    createDirectories = true; # This is the key part
  };
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
