{
  pkgs,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/video/${videoDriver}.nix # Enable gpu videoDrivers defined in flake.nix
    ../../modules/hardware/drives

    ../../modules
  ];

  # Home-manager config
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        # Overlayed [LONG COMPILE]
        gimp
      ];
    })
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [
    vim
    github-copilot-cli
    git
    gh
    gcc
    dysk
    bash
    nodejs_23
    rustup
    cargo
    pkg-config

  ];

  networking.hostName = hostname; # Set hostname defined in flake.nix

  # Stream my media to my devices via the network
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "NixOS-DLNA";
      media_dir = [
        # A = Audio, P = Pictures, V, = Videos, PV = Pictures and Videos.
        # "A,/mnt/work/Pimsleur/Russian"
        "/mnt/work/Pimsleur"
        "/mnt/work/Media/Films"
        "/mnt/work/Media/Series"
        "/mnt/work/Media/Videos"
        "/mnt/work/Media/Music"
      ];
      inotify = "yes";
      log_level = "error";
    };
  };
  users.users.minidlna = {
    extraGroups = ["users"]; # so minidlna can access the files.
  };
}
