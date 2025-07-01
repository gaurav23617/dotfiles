{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [ pkgs.nbfc-linux ];

  systemd.services.nbfc = {
    description = "Notebook FanControl Daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.nbfc-linux}/bin/nbfc_service";
      Restart = "always";
      WorkingDirectory = "/etc/nbfc";
    };
  };

  # Optional: ensure directory exists
  system.activationScripts.nbfcInit = {
    text = ''
      mkdir -p /etc/nbfc
    '';
  };
}
