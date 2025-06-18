{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.home-manager.editor.vscode;
in
{
  options.home-manager.editor.vscode.enable = mkEnableOption "Enable Visual Studio Code";

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };
}
