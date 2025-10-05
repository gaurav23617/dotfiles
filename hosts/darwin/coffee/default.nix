{ config, pkgs, ... }: {
  networking.hostName = "coffee";

  environment.systemPackages = with pkgs; [
    raycast
    rectangle

    # block of shame - no nix package with full integration
    # signal-desktop, tailscale, obs-studio
  ];

  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = true; # DANGER
  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services.nix-daemon.enable = true;
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  # backwards compat; don't change
  system.stateVersion = 4;

  # homebrew = {
  #   enable = true;
  #   caskArgs.no_quarantine = true;
  #   global.brewfile = true;
  #   masApps = { };
  #   casks = [ "raycast" "amethyst" ];
  #   taps = [ "fujiapple852/trippy" ];
  #   brews = [ "trippy" ];
  # };

  users.users."gaurav" = {
    shell = pkgs.zsh;
    home = "/Users/gaurav";
    packages = with pkgs; [
      wget
      k9s
      kubectl
      kubernetes-helm
      xh
      jq
      yq-go
      mosh
      shadowsocks-rust
      # dpkg
      typst
      terraform
      poppler-utils
      tree
      awscli2
      ssm-session-manager-plugin
      pgcli
      rclone
      bat
      kubecm
      colorized-logs
      gh
      dive
      pwgen
      postgresql
      redis
      hyperfine
      htop
      gnumake
      jujutsu
      golangci-lint
      # ollama
      graphviz
      scrcpy
      pnpm
      fd
      grpcurl
      ocrmypdf

      go
      python312
      python312Packages.pyyaml
      pipx
      nodejs_22
      lua
      luarocks
    ];
  };

  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        "64".enabled = false; # Disable 'Cmd + Space' for Spotlight Search
      };
    };
  };
  security.pam.services.sudo_local.touchIdAuth = true;
}
