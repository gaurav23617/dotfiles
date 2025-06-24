{
  config,
  inputs,
  pkgs,
  username,
  ...
}:

let
  # Override nbfc-linux to fix missing libcurl and non-executable nbfc-qt
  patchedNbfc = inputs.nbfc-linux.packages.x86_64-linux.default.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.curl ];
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];

    # Remove nbfc-qt if it exists but is not executable
    postFixup = ''
      if [ -e "$out/bin/nbfc-qt" ] && [ ! -x "$out/bin/nbfc-qt" ]; then
        echo "Removing non-executable nbfc-qt..."
        rm -f "$out/bin/nbfc-qt"
      fi
    '';
  });

  command = "bin/nbfc_service --config-file '/home/${username}/.config/nbfc.json'";
in
{
  environment.systemPackages = [
    patchedNbfc
  ];

  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${patchedNbfc}/${command}";
    };
    path = [ pkgs.kmod ];
    wantedBy = [ "multi-user.target" ];
  };
}
