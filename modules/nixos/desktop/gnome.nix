{ pkgs, ... }: {
  # imports = [ ./dconf.nix ];
  services.xserver.enable = true;
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    #layout = "gb";
    #libinput = { touchpad.tapping = true; };
  };
  # services.gnome.gnome-initial-setup.enable = false;
  services.gnome.games.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.compact-top-bar
    gnomeExtensions.custom-accent-colors
    gradience
    gnomeExtensions.tray-icons-reloaded
    gnome-tweaks
    gnomeExtensions.just-perfection
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.vitals
  ];

  environment.gnome.excludePackages = with pkgs; [
    #pkgs.gnome-backgrounds
    #pkgs.gnome-video-effects
    gnome-maps
    gnome-music
    gnome-tour
    gnome-maps
    gnome-weather
    geary
    gnome-taquin
    gnome-chess
    gnome-contacts
    gnome-text-editor
    gnome-user-docs
    gnome-tetravex
    gnome-mahjongg
    hitori
    four-in-a-row
    five-or-more
    swell-foop
    gnome-nibbles
    quadrapassel
    tali
    atomix
    gnome-2048
    gnome-klotski
    gnome-sudoku
    gnome-tetravex
    gnome-robots
    gnome-mines
  ];
}
