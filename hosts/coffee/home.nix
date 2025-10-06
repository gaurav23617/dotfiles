{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home/tmux.nix
    ../../home/zsh.nix
    ../../home/zen
    ../../home/direnv.nix
    ../../home/starship.nix
    ../../home/nh.nix
    ../../home/btop.nix
    ../../home/git.nix
    ../../home/lazygit.nix
    ../../home/editor/neovim.nix
    ../../home/fastfetch.nix
    ../../home/bat.nix
    ../../home/gh.nix

    ./secrets  # Temporarily comment this out to test
  ];

  # These MUST be set for Darwin
  home.username = "gaurav";
  home.homeDirectory = "/Users/gaurav";

  # Disable XDG on macOS
  xdg.userDirs.enable = false;

  # Create directories manually instead
  home.activation.createCustomDirs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p "$HOME/.config/sops/age"
      $DRY_RUN_CMD mkdir -p "$HOME/personal"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/media"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/projects"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/playground"
      $DRY_RUN_CMD mkdir -p "$HOME/workspace"
    '';

  home.stateVersion = "25.05";
  home.sessionVariables = { EDITOR = "nvim"; };
  programs.home-manager.enable = true;
}
