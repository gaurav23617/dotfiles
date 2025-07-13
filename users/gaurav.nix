# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # TODO: Set your username
  home = {
    username = "gaurav";
    homeDirectory = "/home/gaurav";
  };

  # You can import other home-manager modules here
  imports = [
    ../modules/home/shell/zsh.nix
  ];

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  home.packages = with pkgs; [
    # Terminal
    fzf
    fd
    git
    gh
    vlc
    diff-so-fancy
    eza
    motrix
    nodejs_22
    pnpm
    gh-copilot
    nix-prefetch-scripts
    microfetch
    ripgrep
    zoxide
    bash
    tldr
    unzip
    (pkgs.writeShellScriptBin "hello" ''
      echo "Hello ${username}!"
    '')
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
    TERMINAL = "ghostty";
  };

}
