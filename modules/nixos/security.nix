{ config, ... }:
{
  security = {
    # allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";

    # userland niceness
    rtkit.enable = true;

    # don't ask for password for wheel group
    # sudo.wheelNeedsPassword = false;
  };
}
