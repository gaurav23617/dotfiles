{
  config,
  lib,
  ...
}: {
  imports = [
    # Choose your theme here:
    ../../themes/catppuccin.nix
  ];

  config.var = {
    hostname = "coffee";
    username = "gaurav";
    configDirectory =
      "/home/"
      + config.var.username
      + "/dotfiles"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "India";
    timeZone = "Asia/Kolkata";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "en_US.UTF-8";

    git = {
      username = "gaurav23617";
      email = "gaurav23617@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
