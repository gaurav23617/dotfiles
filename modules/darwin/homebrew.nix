# modules/darwin/homebrew.nix

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  environment.systemPackages = with pkgs; [
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

    # Check if signed into Mac App Store
    if ! ${pkgs.mas}/bin/mas account &> /dev/null; then
      echo "⚠️  Not signed into Mac App Store"
      echo "   Please sign in via the App Store application"
      echo "   Then re-run: darwin-rebuild switch --flake .#coffee"
    else
      echo "✓ Mac App Store: Signed in as $(${pkgs.mas}/bin/mas account)"

      # Check if required apps are in purchase history
      echo "━━━ Checking App Store Apps ━━━"

      # List of app IDs we want to install
      REQUIRED_APPS="310633997"  # WhatsApp

      for app_id in $REQUIRED_APPS; do
        if ${pkgs.mas}/bin/mas list | grep -q "$app_id"; then
          echo "✓ App $app_id: Already in purchase history"
        else
          echo "⚠️  App $app_id: NOT in purchase history"
          echo "   Please open the App Store and click 'Get' for this app"
          echo "   You can cancel the download immediately after"
        fi
      done
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
      cleanup = "uninstall";
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
      "google-drive"
    ];

    brews = [
      "mas" # Ensure mas is available via Homebrew too
    ];

    # Mac App Store apps
    # IMPORTANT: You must "Get" these apps in the Mac App Store at least once
    # to associate them with your Apple ID before they can be installed via mas
    masApps = {
      # "WhatsApp Messenger" = 310633997;
      # Add more apps here after obtaining them in the App Store
      # Use `mas search "app name"` to find IDs
    };
  };
}
