{ lib, inputs, ... }:

let
  utils = import ./utils.nix { inherit lib; };
  inherit (utils) isDarwin isLinux;
in {
  mkHost = hostConfig@{ hostname, platform, system, username ? "gaurav", ... }:
    let
      hostDarwin = isDarwin system;
      homeDirectory =
        if hostDarwin then "/Users/${username}" else "/home/${username}";

      hmModule = if hostDarwin then
        inputs.home-manager.darwinModules.home-manager
      else
        inputs.home-manager.nixosModules.home-manager;

      hostPath = ../hosts/${platform}/${hostname};
      sharedPath = ../modules/common/default.nix;

      diskoConfigPath = "${hostPath}/disk-config.nix";
      hasDiskoConfig = !hostDarwin && builtins.pathExists diskoConfigPath;

      baseModules =
        [ sharedPath "${hostPath}/default.nix" hmModule ];

      linuxModules = if hostDarwin then
        [ ]
      else
        (lib.optional hasDiskoConfig inputs.disko.nixosModules.disko)
        ++ (lib.optional hasDiskoConfig diskoConfigPath)

      systemBuilder = if hostDarwin then
        inputs.darwin.lib.darwinSystem
      else
        inputs.nixpkgs.lib.nixosSystem;
    in systemBuilder {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = baseModules ++ linuxModules ++ [{
       home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
          backupFileExtension = "hm-backup";
          users.${username} = { ... }: {
            imports = [ "${hostPath}/home.nix" ];
          };
        };
      }];
    };
}
