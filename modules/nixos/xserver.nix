{ pkgs, lib, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    exportConfiguration = true; # Make sure /etc/X11/xkb is populated so localectl works correctly

    xkb = {
      layout = "us";
      variant = lib.mkDefault "dvp";
    };
    # Enable Qtile
    windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [ qtile-extras ];
    };
    displayManager.startx.enable = true;
    excludePackages = [ pkgs.xterm ];
  };
}
