{ config, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/nixld.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/bluetooth.nix
    # ../../modules/nixos/home-manager.nix
    # ../../modules/nixos/desktop/gnome
    ../../modules/nixos/desktop/hyprland.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/common/nix.nix
    ../../modules/common/packages.nix
    ../../home/docker.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  networking.hostName = "atlas"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.gaurav = {
      isNormalUser = true;
      description = "Gaurav";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs;
        [
          #  thunderbird
        ];
    };
  };

  programs.zsh.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gaurav";

  system.stateVersion = "25.05"; # Did you read the comment?
}
