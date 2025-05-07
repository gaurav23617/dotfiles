{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

with lib;

let
  # Detect if the system is Linux or macOS
  isLinux = pkgs.stdenv.isLinux;
  config_name = if isLinux then "linux-config" else "mac-config";
in
{
  options.within.ghostty.enable = mkEnableOption "Enables ghostty Terminal Settings";

  config = mkIf config.within.ghostty.enable {
    nixpkgs = {
      overlays = [
        inputs.brew-nix.overlays.default
      ];
    };

    # Conditional package inclusion based on the system (Linux vs Mac)
    home.packages = (
      if isLinux then
        [
          inputs.ghostty.packages."${pkgs.system}".default
        ]
      else
        [ pkgs.brewCasks.ghostty ] # Use Homebrew for macOS
    );

    # Files for both Linux and macOS, symlinks to dotfiles folder
    home.file = {
      ".config/ghostty/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/ghostty/config";
      };
      ".config/ghostty/${config_name}" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfile/ghostty/${config_name}";
      };
    };
  };
}
