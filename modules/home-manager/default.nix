# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    # fonts
    ./fonts.nix

    # Browsers
    ./browsers/zen.nix
    ./browsers/browser.nix

    # Cli tools
    ./cli/nh.nix
    ./cli/direnv.nix
    ./cli/git.nix
    ./cli/gh.nix
    ./cli/starship.nix

    # Editor and IDEs
    ./editor/neovim.nix
    ./editor/vscode.nix

    # Miscellaneous
    ./misc/cpufreq.nix
    ./misc/lact.nix
    ./misc/nix-ld.nix
    ./misc/thunar.nix
    ./misc/tlp.nix

    # Shells
    ./shell/zsh.nix
    ./shell/nushell.nix

    # Terminal
    ./terminal/ghostty.nix
    ./terminal/kitty.nix

    ./obsidian.nix
  ];
}
