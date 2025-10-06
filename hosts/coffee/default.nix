# hosts/darwin/coffee/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  ids.gids.nixbld = 350;

  # Set the primary user for system defaults
  system.primaryUser = "gaurav";

  # Allow unfree packages
  nixpkgs.config.allowBroken = true;

  nix = {
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
    wget
    btop
    # Build tools that replace/supplement Xcode Command Line Tools
    darwin.cctools
    clang
    llvmPackages.bintools
    gnumake
    pkg-config
  ];

  environment = {
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  environment.variables = {
    HOMEBREW_PREFIX = "/opt/homebrew";
    HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
    HOMEBREW_REPOSITORY = "/opt/homebrew";
  };

  # IMPORTANT: This installs Homebrew via nix-homebrew
  nix-homebrew = {
    enable = true;
    user = "gaurav";
    enableRosetta = true; # This enables Rosetta support
    autoMigrate = false;

    # Key: install Homebrew if not present
    # This will happen BEFORE the homebrew module tries to run
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
  };

  # System activation scripts to ensure prerequisites are installed
  system.activationScripts.preActivation.text = ''
    echo "━━━ Checking Prerequisites ━━━"

    # Check and install Xcode Command Line Tools
    if ! xcode-select -p &> /dev/null; then
      echo "Installing Xcode Command Line Tools..."
      # This triggers the installation without blocking
      touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
      PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
      if [ -n "$PROD" ]; then
        softwareupdate -i "$PROD" --verbose
        echo "✓ Xcode Command Line Tools: Installed"
      else
        echo "⚠️  Could not auto-install. Run manually: xcode-select --install"
      fi
      rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    else
      echo "✓ Xcode Command Line Tools: $(xcode-select -p)"
    fi

    # Check and install Rosetta 2
    if /usr/bin/pgrep -q oahd; then
      echo "✓ Rosetta 2: Installed"
    else
      echo "Installing Rosetta 2..."
      if /usr/sbin/softwareupdate --install-rosetta --agree-to-license 2>/dev/null; then
        echo "✓ Rosetta 2: Installed successfully"
      else
        echo "⚠️  Rosetta 2 installation failed. Run manually:"
        echo "   sudo softwareupdate --install-rosetta --agree-to-license"
      fi
    fi

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  '';

  # Configure what to install via Homebrew
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    # Only enable if brew is already installed
    # This prevents the error on first run
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];

    casks = [
      "google-chrome"
      "spotify"
      "raycast"
      "blip"
    ];

    brews = [ ];
    masApps = {
      # "WhatsApp Messenger" = 310633997;
    };
  };

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.orientation = "bottom";
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  system.stateVersion = 4;
}
