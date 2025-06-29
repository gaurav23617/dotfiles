{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.obsidian = {
        enable = true;
        package = pkgs.obsidian;
        vaults = {
          brain-log = {
            enable = true;
            path = "~/obsidian/brain-log"; # This would be the default. (Based on the name)

            # community-plugins = {
            #   # List of plugin names translate to vault/.obsidian/community-plugins.json:
            #   # [ "plugin-1", "plugin-2" ]
            #
            #   obsidian-style-settings = {
            #     enable = true;
            #     config = {
            #       # Configuration in here would translate to
            #       # vault/.obsidian/plugins/obsidian-style-settings/data.json
            #     };
            #   };
            # };
            #
            # core-plugins = {
            #   # Format in vault/.obsidian/core-plugins.json is different:
            #   # { "plugin-1": true, "plugin-2": false }
            #
            #   file-explorer = {
            #     enable = true;
            #     config = {
            #       # Configuration here would translate to
            #       # vault/.obsidian/plugins/file-explorer/data.json
            #     };
            #   };
            # };
            #
            # extraConfig = {
            #   app = {
            #     # Directly translates to vault/.obsidian/app.json
            #   };
            #   appearance = {
            #     # Directly translates to vault/.obsidian/appearance.json
            #   };
            #   # etc.
            # };
          };
        };
      };
    })
  ];
}
