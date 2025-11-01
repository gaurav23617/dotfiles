# lib/default.nix
{inputs}:
import ./mkConfigHelper.nix {
  inherit inputs;
  lib = inputs.nixpkgs.lib;
}
