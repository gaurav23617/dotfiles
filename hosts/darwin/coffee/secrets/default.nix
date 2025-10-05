{ config, pkgs, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    # FIXED: Replaced "/home/gaurav" with a dynamic path
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../../../secrets/secrets.yaml;

    secrets = {
      sshconfig = { path = "${config.home.homeDirectory}/.ssh/config"; };
      github-key = { path = "${config.home.homeDirectory}/.ssh/github"; };
      signing-key = { path = "${config.home.homeDirectory}/.ssh/key"; };
      signing-pub-key = { path = "${config.home.homeDirectory}/.ssh/key.pub"; };
      allowed-signers = {
        path = "${config.home.homeDirectory}/.ssh/allowed_signers";
      };
    };
  };

  home.packages = with pkgs; [ sops age ];
}
