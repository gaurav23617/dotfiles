{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  # Optional: Uncomment if you want custom cache paths
  # home.sessionVariables = {
  #   DIRENV_DIR = "/tmp/direnv";
  #   DIRENV_CACHE = "/tmp/direnv-cache";
  # };
}
