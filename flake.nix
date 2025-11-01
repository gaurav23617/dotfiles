{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Pin a specific nixpkgs revision with GTK+3 3.24.49 for zen-browser
    nixpkgs-pinned-gtk3 = {
      url = "github:NixOS/nixpkgs/5b5b46259bef947314345ab3f702c56b7788cab8";
      flake = false;
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
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
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
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
    ghostty.url = "github:ghostty-org/ghostty";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixCats,
    vicinae,
    nix-darwin,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    ...
  } @ inputs: let
    # System definitions
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-darwin"];

    pkgs-gtk3 = import nixpkgs {
      system = "aarch64-darwin";
      config.allowUnfree = true;
      overlays = [
        inputs.brew-nix.overlays.default
        # The GTK3 overlay
        (final: prev: {
          gtk3 =
            (import inputs.nixpkgs-pinned-gtk3 {
              system = prev.system;
              config.allowUnfree = true;
            }).gtk3;
        })
      ];
    };
  in {
    nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self;};
      modules = [
        ./hosts/atlas/default.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gaurav = import ./hosts/atlas/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    darwinConfigurations.coffee = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = pkgs-gtk3;
      specialArgs = {inherit inputs self;};
      modules = [
        ./hosts/coffee/default.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.backupFileExtension = "backup";
          home-manager.users.gaurav = {
            imports = [./hosts/coffee/home.nix];
            home = {
              username = nixpkgs.lib.mkForce "gaurav";
              homeDirectory = nixpkgs.lib.mkForce "/Users/gaurav";
            };
          };
        }
      ];
    };

    homeConfigurations = {
      "gaurav@coffee" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-gtk3;
        extraSpecialArgs = {inherit inputs;}; # ✓ Already correct
        modules = [
          ./hosts/coffee/home.nix
          {
            home.username = "gaurav";
            home.homeDirectory = "/Users/gaurav";
          }
        ];
      };
      "gaurav@atlas" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;}; # ✓ Already correct
        modules = [
          ./hosts/atlas/home.nix
          {
            home.username = "gaurav";
            home.homeDirectory = "/home/gaurav";
          }
        ];
      };
    };
  };
}
