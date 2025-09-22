{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    neovim
    wget
    google-chrome
    ghostty
    home-manager
    wl-clipboard
  ];
}
