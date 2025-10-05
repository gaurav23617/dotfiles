# lib/mkConfigHelper.nix
{ inputs, lib }:

let
  isPlatform = system: platform: builtins.match ".*-${platform}" system != null;
  isDarwin = system: isPlatform system "darwin";
  isLinux = system: isPlatform system "linux";

in {
  inherit isLinux isDarwin isPlatform;

  mkHost = hostArgs:
    let
      inherit (hostArgs) system hostname username;
      platform = if isDarwin system then "darwin" else "linux";

      systemBuilder = if platform == "darwin" then
        inputs.nix-darwin.lib.darwinSystem
      else
        inputs.nixpkgs.lib.nixosSystem;

      homeManagerModule = if platform == "darwin" then
        inputs.home-manager.darwinModules.home-manager
      else
        inputs.home-manager.nixosModules.home-manager;

    in systemBuilder {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        ../hosts/${platform}/${hostname}/default.nix

        homeManagerModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.${username} = ../hosts/${platform}/${hostname}/home.nix;
          };
        }
      ];
    };

  mkHomeConfig = hostArgs:
    let
      inherit (hostArgs) system hostname;
      platform = if isDarwin system then "darwin" else "linux";
    in inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs; };
      modules = [ ../hosts/${platform}/${hostname}/home.nix ];
    };
}
