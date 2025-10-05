{ config, pkgs, lib, username, homeDirectory, ... }:

{
  imports = [
    ../../../home/tmux.nix
    ../../../home/zsh.nix
    ../../../home/zen
    ../../../home/direnv.nix
    ../../../home/starship.nix
    ../../../home/nh.nix
    ../../../home/btop.nix
    ../../../home/git.nix
    ../../../home/lazygit.nix
    ../../../home/editor/neovim.nix
    ../../../home/fastfetch.nix
    ../../../home/bat.nix
    ../../../home/gh.nix

    ./secrets
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Create custom directories
  home.activation.createCustomDirs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p "${homeDirectory}/.config/sops/age"
      $DRY_RUN_CMD mkdir -p "${homeDirectory}/personal"
      $DRY_RUN_CMD mkdir -p "${homeDirectory}/personal/media"
      $DRY_RUN_CMD mkdir -p "${homeDirectory}/personal/projects"
      $DRY_RUN_CMD mkdir -p "${homeDirectory}/personal/playground"
      $DRY_RUN_CMD mkdir -p "${homeDirectory}/workspace"
    '';

  home.stateVersion = "25.05";
  home.sessionVariables = { EDITOR = "nvim"; };
  programs.home-manager.enable = true;
}
