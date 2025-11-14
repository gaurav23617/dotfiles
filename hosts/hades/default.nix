{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko-config.nix
    # ../../home/docker.nix
    ../../modules/common
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["nvidia-drm.modeset=1"];

  networking.hostName = "hades"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  environment.systemPackages = with pkgs; [neovim vim wget];
  # Enable CUPS to print documents.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.indie = {
      isNormalUser = true;
      description = "indiefluence server";
      extraGroups = ["networkmanager" "wheel" "docker"];
      packages = with pkgs; [
        #  thunderbird
      ];
    };
  };

  programs.zsh.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "hades";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}
