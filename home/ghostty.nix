{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  config_name = if pkgs.stdenv.isLinux then "linux-config" else "mac-config";
in
{
  home.packages =
    if pkgs.stdenv.isLinux then
      [ inputs.ghostty.packages."${pkgs.stdenv.hostPlatform.system}".default ]
    else
      [ pkgs.brewCasks.ghostty ];

  home.file.".config/ghostty".source = builtins.toString (
    config.lib.file.mkOutOfStoreSymlink ../config/ghostty
  );
}
