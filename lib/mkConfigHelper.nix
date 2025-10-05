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

      # Determine home directory based on platform
      homeDirectory = if platform == "darwin" then
        "/Users/${username}"
      else
        "/home/${username}";

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
            extraSpecialArgs = { inherit inputs username homeDirectory; };
            users.${username} = { ... }: {
              imports = [ ../hosts/${platform}/${hostname}/home.nix ];
              home = { inherit username homeDirectory; };
            };
          };
        }
      ];
    };

  mkHomeConfig = hostArgs:
    let
      inherit (hostArgs) system hostname username;
      platform = if isDarwin system then "darwin" else "linux";
      homeDirectory = if platform == "darwin" then
        "/Users/${username}"
      else
        "/home/${username}";
    in inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs username homeDirectory; };
      modules = [ ../hosts/${platform}/${hostname}/home.nix ];
    };
}
