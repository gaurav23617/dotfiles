{ config, pkgs, inputs, homeDirectory, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../../../secrets/secrets.yaml;

    secrets = {
      sshconfig = { path = "${homeDirectory}/.ssh/config"; };
      github-key = { path = "${homeDirectory}/.ssh/github"; };
      signing-key = { path = "${homeDirectory}/.ssh/key"; };
      signing-pub-key = { path = "${homeDirectory}/.ssh/key.pub"; };
      allowed-signers = { path = "${homeDirectory}/.ssh/allowed_signers"; };
    };
  };

  home.packages = with pkgs; [ sops age ];
}
