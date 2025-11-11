{
  config,
  pkgs,
  ...
}: {
  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ${config.home.homeDirectory}/.npm
    '';
  };
}
