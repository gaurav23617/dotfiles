{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ../../home/tmux.nix
    ../../home/zsh.nix
    ../../home/zen.nix
    ../../home/direnv.nix
    ../../home/starship.nix
    ../../home/nh.nix
    ../../home/btop.nix
    # ../../home/docker.nix
    ../../home/git.nix
    ../../home/lazygit.nix
    ../../home/lazydocker.nix
    ../../home/neovim.nix
    ../../home/fastfetch.nix
    ../../home/bat.nix
    ../../home/gh.nix
    ../../home/hyprland
    ../../home/waybar
    ../../home/vicinae.nix

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
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;

}
