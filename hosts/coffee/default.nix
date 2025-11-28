# hosts/coffee/default.nix
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
    # nushell
  ];
  environment.shells = [
    # pkgs.nushell
    pkgs.zsh
  ];

  users.users.gaurav = {
    description = "Gaurav";
    home = "/Users/gaurav";
    shell = pkgs.zsh;
  };
}
