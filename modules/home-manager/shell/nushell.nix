{
  home-manager.sharedModules = [
    (
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        programs = {
          nushell = {
            enable = true;
            configFile.source = .config/nutshell;
          };
        };
      }
    )
  ];
}
