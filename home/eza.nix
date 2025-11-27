{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
    git = true;
    colors = "always";
    extraOptions = [
      "--group-directories-first"
      "--hyperlink"
      "--no-quotes"
      "--header" # Show header row
      "--hyperlink" # make paths clickable in some terminals
    ];
  };
  home.file.".config/eza".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink ../config/eza
  );
}
