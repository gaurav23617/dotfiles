# This is a NixOS system configuration file for the user
# It defines system-level user settings
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # System-level user configuration
  users.users.gaurav = {
    initialPassword = "$y$j9T$9IhPCib6d/887Lu3GkASg/$M4bf4upZzcN.qnYHDfxVqK37tiC//5jgKbfu5AV0pSB";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    shell = pkgs.zsh;  # Set default shell
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;
}
