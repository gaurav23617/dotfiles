{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.misc.lact;
in
{
  options.misc.lact.enable =
    mkEnableOption "Enable lact (Linux Advanced Configuration Tool)";

  config = mkIf cfg.enable {
    systemd = {
      packages = with pkgs; [ lact ];
      services.lactd.wantedBy = [ "multi-user.target" ];
    };
    environment.systemPackages = with pkgs; [ lact ];
  };
}
