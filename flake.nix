{
  description = "NixOS from Scratch";

  inputs = {
    ./inputs.nix;
  };

  outputs =
    {
      self,
      nixpkgs,
      vicinae,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      ...
    }@inputs:
    {
      nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/atlas/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gaurav = import ./hosts/atlas/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      darwinConfigurations.coffee = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/coffee/default.nix
          # Add the brew-nix overlay here
          {
            nixpkgs.overlays = [
              inputs.brew-nix.overlays.default
            ];
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.gaurav = {
              imports = [ ./hosts/coffee/home.nix ];
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
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
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
          extraSpecialArgs = { inherit inputs; };
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
