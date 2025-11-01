{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    luarocks
    nixpkgs-fmt
  ];
}
