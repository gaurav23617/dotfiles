{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      libertinus
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      (google-fonts.override { fonts = [ "Inter" ]; })

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.caskaydia-cove
      nerd-fonts.bigblue-terminal
      nerd-fonts.victor-mono
      nerd-fonts.zed-mono
      nerd-fonts.mononoki
      nerd-fonts.heavy-data
      nerd-fonts.inconsolata
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      maple-mono.truetype
      maple-mono.NF-unhinted

    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    fontconfig.defaultFonts = {
      serif = [ "Libertinus Serif" ];
      sansSerif = [ "Inter" ];
      monospace = [ "JetBrains Mono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
