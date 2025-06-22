{ hostname, ... }:
{
  networking = {
    hostName = hostname; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        57621
        7236
        7250
        42355
        # syncthing
        22000
      ];
      allowedUDPPorts = [
        59010
        59011
        7236
        5353
        # syncthing QUIC
        22000
        # syncthing discovery broadcast on ipv4 and multicast ipv6
        21027
      ];
    };
  };
}
