# Spicetify is a spotify client customizer
{ pkgs, config, lib, inputs, ... }: {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    # theme = lib.mkForce spicePkgs.themes.dribbblish;

    # customColorScheme = {
    #   button = accent;
    #   button-active = accent;
    #   tab-active = accent;
    #   player = background;
    #   main = background;
    #   sidebar = background;
    # };

    # enabledExtensions = with spicePkgs.extensions; [
    #   playlistIcons
    #   lastfm
    #   historyShortcut
    #   hidePodcasts
    #   adblock
    #   fullAppDisplay
    #   keyboardShortcut
    # ];
  };
}
