{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    neovim
    wget
    google-chrome
    libreoffice-qt6-fresh
    ghostty
    home-manager
    wl-clipboard
    fd
    bc
    gcc
    git-ignore
    go
    comma
  ];
}
