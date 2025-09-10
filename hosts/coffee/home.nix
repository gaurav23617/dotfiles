{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/nvf
    ../../home/programs/nh
    ../../home/programs/btop
    ../../home/programs/tmux
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/github.nix
    # ../../home/programs/git/signing.nix
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/lazygit
    ../../home/programs/zen
    ../../home/programs/discord
    ../../home/programs/tailscale

    # Scripts
    ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/hyprlock
    # ../../home/system/hyprpanel
    ../../home/system/waybar
    ../../home/system/hyprpaper
    ../../home/system/wofi
    ../../home/system/zathura
    ../../home/system/mime
    ../../home/system/udiskie
    # ../../home/system/hypridle
    ../../home/system/clipman
    ../../home/chrome.nix

    # ./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      vlc # Video player
      obsidian # Note taking app
      textpieces # Manipulate texts
      curtail # Compress images
      resources # Ressource monitor
      gnome-clocks # Clocks app
      gnome-text-editor # Basic graphic text editor
      mpv # Video player
      brave # Web browser

      # Privacy
      session-desktop # Session app, private messages

      # Dev
      go
      nodejs
      python3
      jq
      just
      pnpm
      air
      duckdb

      # Utils
      zip
      unzip
      optipng
      jpegoptim
      pfetch
      fastfetch

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix

      # Backup
      vscode
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = {source = ./profile_picture.png;};

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
