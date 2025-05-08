{
  videoDriver,
  browser,
  editor,
  terminal,
  terminalFileManager,
  ...
}:

{
  imports = [
    ./hardware/video/${videoDriver}.nix # Enable gpu drivers defined in flake.nix
    ./hardware/drives

    ./scripts

    ./desktop/hyprland # Enable hyprland window manager

    ./programs/games
    ./programs/git
    ./programs/browser/zen # Set browser defined in flake.nix
    ./programs/browser/brave
    ./programs/terminal/${terminal} # Set terminal defined in flake.nix
    ./programs/editor/neovim # Set editor defined in flake.nix
    ./programs/editor/vscode
    ./programs/cli/yazi # Set file-manager defined in flake.nix
    ./programs/cli/starship
    ./programs/cli/tmux
    ./programs/cli/direnv
    ./programs/cli/lazygit
    ./programs/cli/cava
    ./programs/cli/btop
    ./programs/zsh
    ./programs/media/discord
    ./programs/media/spicetify
    ./programs/misc/tlp
    ./programs/misc/virt-manager
    ./programs/misc/lact # gpu power and fan control (WIP)
  ];
}
