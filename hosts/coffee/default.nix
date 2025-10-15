# hosts/darwin/coffee/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/darwin
    ../../modules/common
  ];

  ids.gids.nixbld = 350;

  networking.hostName = "coffee";

  # Set the primary user for system defaults
  system.primaryUser = "gaurav";

  # Allow unfree packages
  nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    darwin.cctools
    llvmPackages.bintools
  ];
}
