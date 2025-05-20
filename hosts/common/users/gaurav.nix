{
  config,
  pkgs,
  inputs,
  ...
}:
{
  users.users.gaurav = {
    initialHashedPassword = "$y$j9T$dAWv8pFBx9tHQKeElCWu41$awYuhwpDwDhZxQ5.RVZORKcm1bxXpeWK0LPAnGHxNX6";
    isNormalUser = true;
    description = "gaurav";
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
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };
  home-manager.users.gaurav = import ../../../home/gaurav/${config.networking.hostName}.nix;
}
