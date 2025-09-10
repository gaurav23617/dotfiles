{
  programs.google-chrome = {
    enable = true;
    commandLineArgs = [
      # Wayland support for better integration with Hyprland
      "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
      "--ozone-platform=wayland"
      "--enable-wayland-ime"

      # Performance optimizations without triggering enterprise detection
      "--disable-features=UseChromeOSDirectVideoDecoder"
      "--enable-gpu-rasterization"
      "--show-managed-ui=false"
      "--disable-features=ChromeWhatsNewUI"
    ];
  };
}
