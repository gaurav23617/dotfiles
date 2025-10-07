# hosts/darwin/coffee/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ../../modules/darwin ];

  ids.gids.nixbld = 350;

  networking.hostName = "coffee";

  # Set the primary user for system defaults
  system.primaryUser = "gaurav";

  # Allow unfree packages
  nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    coreutils
    wget
    darwin.cctools
    clang
    llvmPackages.bintools
    gnumake
    pkg-config
  ];
}
