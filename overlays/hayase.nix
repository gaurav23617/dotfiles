{ prev }:
prev.miru.overrideAttrs (
  oldAttrs:
  let
    latestSrc = builtins.fetchGit {
      url = "https://github.com/ThaUnknown/miru.git";
      ref = "main"; # or whatever branch you want to track
    };
  in
  {
    src = latestSrc;
    version = "unstable-${builtins.substring 0 7 latestSrc.rev}";
  }
)
