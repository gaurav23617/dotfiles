{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      roboto
      work-sans
      comic-neue
      inter
      lato
      (google-fonts.override { fonts = [ "Inter" ]; })
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.zed-mono
    ];

    enableDefaultPackages = false;
  };
}
