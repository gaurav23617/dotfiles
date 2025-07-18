{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.editor.vscode;
in
{
  options.editor.vscode.enable = mkEnableOption "Enable Visual Studio Code";

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };
}
