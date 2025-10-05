{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    vicinae.url = "github:vicinaehq/vicinae";
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, vicinae, home-manager, ... }:
    let
      lib = nixpkgs.lib.extend
        (final: prev: { my = import ./lib { inherit inputs; }; });

      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      hosts = {
        "coffee" = {
          hostname = "coffee";
          system = "aarch64-darwin";
          username = "gaurav";
        };
        "atlas" = {
          hostname = "atlas";
          system = "x86_64-linux";
          username = "gaurav";
        };
      };

      forAllHosts = f: builtins.mapAttrs (name: host: f host);

    in {
      # Build NixOS configs using the isLinux helper for clarity
      nixosConfigurations =
        builtins.mapAttrs (name: hostConfig: lib.my.mkHost hostConfig)
        (lib.filterAttrs (name: hostConfig: lib.my.isLinux hostConfig.system)
          hosts);

      # Build Darwin configs using the isDarwin helper
      darwinConfigurations =
        builtins.mapAttrs (name: hostConfig: lib.my.mkHost hostConfig)
        (lib.filterAttrs (name: hostConfig: lib.my.isDarwin hostConfig.system)
          hosts);

      # Build home configs for all hosts
      homeConfigurations = forAllHosts lib.my.mkHomeConfig;
    };
}
