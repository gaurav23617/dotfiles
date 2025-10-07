{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./homebrew.nix
    ./settings.nix
  ];

  # nix config
  nix = {
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

  nixpkgs.config.allowUnfree = true;
}
