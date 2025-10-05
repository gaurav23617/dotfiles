# Those are my secrets, encrypted with sops
# You shouldn't import this file, unless you edit it
{ pkgs, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "/home/gaurav/.config/sops/age/keys.txt";
    # defaultSopsFile = ./secrets.yaml;
    defaultSopsFile = ../../../../secrets/secrets.yaml;
    secrets = {
      sshconfig = { path = "/home/gaurav/.ssh/config"; };
      github-key = { path = "/home/gaurav/.ssh/github"; };
      signing-key = { path = "/home/gaurav/.ssh/key"; };
      signing-pub-key = { path = "/home/gaurav/.ssh/key.pub"; };
      allowed-signers = { path = "/home/gaurav/.ssh/allowed_signers"; };
    };
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  home.packages = with pkgs; [ sops age ];

  wayland.windowManager.hyprland.settings.exec-once =
    [ "systemctl --user start sops-nix" ];
}
