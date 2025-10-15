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

    let
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
    in
    {
      nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
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
        # Use the special pkgs set
        pkgs = pkgs-gtk3;
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/coffee/default.nix
          # Note: The overlays are now part of pkgs-gtk3,
          # so they don't need to be listed here again.
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
          # Use the same special pkgs set here
          pkgs = pkgs-gtk3;
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
