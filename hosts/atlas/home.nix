{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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
    ../../../home/lazydocker.nix
    ../../../home/editor/neovim.nix
    ../../../home/editor/vscode.nix
    ../../../home/editor/zed.nix
    ../../../home/fastfetch.nix
    ../../../home/bat.nix
    ../../../home/gh.nix
    ../../../home/hyprland
    ../../../home/waybar
    ../../../home/spicetify.nix
    ../../../home/vicinae.nix
    ../../../home/thunar.nix

    ./secrets
  ];

  home.username = "gaurav";
  home.homeDirectory = "/home/gaurav";

  home.packages = [ ];
  home.file = { };
  xdg.userDirs = {
    enable = true;
    createDirectories = true; # This is the key part
  };

  # this piece of code is for creating empty directories
  home.activation.createCustomDirs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p "$HOME/.config/sops/age"
      $DRY_RUN_CMD mkdir -p "$HOME/personal"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/media"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/projects"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/playground"
      $DRY_RUN_CMD mkdir -p "$HOME/workspace"
    '';

  programs.home-manager.enable = true;
  home.sessionVariables = { EDITOR = "nvim"; };
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
