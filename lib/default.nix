# lib/default.nix
{ inputs }:
import ./mkConfigHelper.nix {
  inherit inputs;
  inherit (inputs.nixpkgs) lib;
}
