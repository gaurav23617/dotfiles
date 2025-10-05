# lib/mkConfigHelper.nix
{ inputs, lib }:

let
  isPlatform = system: platform: builtins.match ".*-${platform}" system != null;
  isDarwin = system: isPlatform system "darwin";
  isLinux = system: isPlatform system "linux";

  getHostInfo = hostArgs:
    let inherit (hostArgs) system username;
    in {
      inherit username;
      platform = if isDarwin system then "darwin" else "linux";
      homeDirectory =
        if isDarwin system then "/Users/${username}" else "/home/${username}";
    };

in {
  inherit isLinux isDarwin isPlatform;

  mkHost = hostArgs:
    let
      inherit (hostArgs) system hostname;
      hostInfo = getHostInfo hostArgs;

      systemBuilder = if hostInfo.platform == "darwin" then
        inputs.nix-darwin.lib.darwinSystem
      else
        inputs.nixpkgs.lib.nixosSystem;

      homeManagerModule = if hostInfo.platform == "darwin" then
        inputs.home-manager.darwinModules.home-manager
      else
        inputs.home-manager.nixosModules.home-manager;

    in systemBuilder {
      inherit system;
      specialArgs = {
        inherit inputs;
        inherit (hostInfo) username homeDirectory platform;
      };

      modules = [
        ../hosts/${hostInfo.platform}/${hostname}/default.nix

        homeManagerModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs;
              username = hostInfo.username;
              homeDirectory = hostInfo.homeDirectory;
              platform = hostInfo.platform;
            };
            users.${hostInfo.username} =
              ../hosts/${hostInfo.platform}/${hostname}/home.nix;
          };
        }
      ];
    };

  mkHomeConfig = hostArgs:
    let hostInfo = getHostInfo hostArgs;
    in inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${hostArgs.system};
      extraSpecialArgs = {
        inherit inputs;
        username = hostInfo.username;
        homeDirectory = hostInfo.homeDirectory;
        platform = hostInfo.platform;
      };

      modules = [ ../hosts/${hostInfo.platform}/${hostArgs.hostname}/home.nix ];
    };
}
