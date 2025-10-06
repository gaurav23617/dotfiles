# hosts/darwin/coffee/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ../../modules/darwin/homebrew.nix ];

  ids.gids.nixbld = 350;

  # Set the primary user for system defaults
  system.primaryUser = "gaurav";

  # Allow unfree packages
  nixpkgs.config.allowBroken = true;

  nix = {
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
    wget
    darwin.cctools
    clang
    llvmPackages.bintools
    gnumake
    pkg-config
  ];

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.orientation = "bottom";
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  system.stateVersion = 4;
}
