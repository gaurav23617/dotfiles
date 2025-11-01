{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [delta git-cliff];
  programs.git = {enable = true;};
  home.file.".config/git" = {
    recursive = true;
    source = ../config/git;
  };
}
