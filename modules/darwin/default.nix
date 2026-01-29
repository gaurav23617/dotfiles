{
  pkgs,
  inputs,
  self,
  ...
}:
{
  imports = [
    ./homebrew.nix
    ./settings.nix
    ./packages.nix
    ./fonts.nix
    ./nix.nix
  ];
}
