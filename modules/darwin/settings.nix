{ self, ... }:
{
  # touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # system defaults and preferences
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;

    startup.chime = false;

    defaults = {
      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };

      finder = {
        AppleShowAllFiles = true; # hidden files
        AppleShowAllExtensions = true; # file extensions
        _FXShowPosixPathInTitle = true; # title bar full path
        ShowPathbar = true; # breadcrumb nav at bottom
        ShowStatusBar = true; # file count & disk space
      };

      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };

      dock = {
        orientation = "bottom";
        autohide = true;
      };
    };
  };

  system.stateVersion = 6;
}
