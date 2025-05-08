{ pkgs, ... }:

{
  home.packages = [
    pkgs.brave
    pkgs.google-chrome
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  };
}
