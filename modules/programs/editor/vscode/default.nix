{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      {
        programs.vscode = {
          enable = true;
          package = pkgs.vscode;
        };
      }
    )
  ];
}
