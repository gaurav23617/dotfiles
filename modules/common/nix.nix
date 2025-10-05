# Nix configuration for NixOS
{ config, inputs, ... }: {
  # Allow unfree packages
  nixpkgs = {
    hostPlatform = system;
    config.allowUnfree = true;
    config.allowBroken = true;
  };
  nix = {
    channel.enable = false;
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"

        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];

      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys =
        [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
