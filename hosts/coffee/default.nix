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
  system.primaryUser = "gaurav";

  nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    darwin.cctools
    llvmPackages.bintools
  ];
  environment.shells = [ pkgs.nushell ];
  users.users.gaurav = {
    description = "Gaurav";
    home = "/Users/gaurav";
    # shell = pkgs.nushell;
  };
}
