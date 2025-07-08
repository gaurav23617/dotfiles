{
  pkgs,
  settings,
  ...
}:
{
  sddm-astronaut = pkgs.callPackage ./sddm-themes/astronaut.nix { theme = settings.sddmTheme; };
  hayase = pkgs.callPackage ./hayase.nix { }; # Add this line
}
