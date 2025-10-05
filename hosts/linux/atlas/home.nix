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
    ../../../home/docker.nix
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
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = [ ];
  home.file = { };
  programs.git.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = { btw = "echo i use nixos, btw"; };
  };
  home.sessionVariables = { EDITOR = "nvim"; };
  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true; # This is the key part
  };

  home.activation.createCustomDirs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p "$HOME/.config/sops/age"
      $DRY_RUN_CMD mkdir -p "$HOME/personal"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/media"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/projects"
      $DRY_RUN_CMD mkdir -p "$HOME/personal/playground"
      $DRY_RUN_CMD mkdir -p "$HOME/workspace"
    '';
}
