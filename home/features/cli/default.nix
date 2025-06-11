{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraOptions = [
      "-l"
      "--icons"
      "--git"
      "-a"
    ];
  };

  programs.bat = {
    enable = true;
  };

  home.packages = with pkgs; [
    coreutils
    fd
    btop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
    unzip
  ];
}
