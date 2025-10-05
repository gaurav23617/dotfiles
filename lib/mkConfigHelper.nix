# lib/mkConfigHelper.nix
{ inputs, lib }:

let
  isPlatform = system: platform: builtins.match ".*-${platform}" system != null;
  isDarwin = system: isPlatform system "darwin";
  isLinux = system: isPlatform system "linux";

  # Gathers common information about a host.
  getHostInfo = hostArgs:
    let inherit (hostArgs) system username;
    in {
      inherit username;
      platform = if isDarwin system then "darwin" else "linux";
      homeDirectory =
        if isDarwin system then "/Users/${username}" else "/home/${username}";
    };

in {
  # Make isLinux and isDarwin available to the flake.
  inherit isLinux isDarwin isPlatform;

  # Builds the complete NixOS or Darwin system.
  mkHost = hostArgs:
    let
      inherit (hostArgs) system hostname;
      hostInfo = getHostInfo hostArgs;
      systemBuilder = if hostInfo.platform == "darwin" then
        inputs.nix-darwin.lib.darwinSystem
      else
        inputs.nixpkgs.lib.nixosSystem;

      # Choose the correct Home Manager module based on platform
      homeManagerModule = if hostInfo.platform == "darwin" then
        inputs.home-manager.darwinModules.home-manager
      else
        inputs.home-manager.nixosModules.home-manager;

    in systemBuilder {
      inherit system;
      specialArgs = {
        inherit inputs;
      } // hostInfo // (hostArgs.specialArgs or { });

      modules = [
        # Machine-specific configuration.
        ../hosts/${hostInfo.platform}/${hostname}/default.nix

        # Home Manager integration (platform-specific).
        homeManagerModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; } // hostInfo;
            users.${hostInfo.username} = {
              imports = [ ../hosts/${hostInfo.platform}/${hostname}/home.nix ];
              home.username = hostInfo.username;
              home.homeDirectory = hostInfo.homeDirectory;
            };
          };
        }
      ];
    };

  # Builds a standalone Home Manager configuration.
  mkHomeConfig = hostArgs:
    let hostInfo = getHostInfo hostArgs;
    in inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${hostArgs.system};
      extraSpecialArgs = { inherit inputs; } // hostInfo;

      modules = [
        ../hosts/${hostInfo.platform}/${hostArgs.hostname}/home.nix
        {
          home.username = hostInfo.username;
          home.homeDirectory = hostInfo.homeDirectory;
        }
      ];
    };
}
