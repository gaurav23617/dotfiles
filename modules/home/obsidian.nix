{ config, lib, ... }:
with lib;

let
  cfg = config.programs.obsidian;
in
{
  options.programs.obsidian.enable = mkEnableOption "Enable obsidian";

  config = mkIf cfg.enable {

    programs.obsidian = {
      enable = true;
      package = pkgs.obsidian;
      vaults = {
        brain-log = {
          enable = true;
          path = "~/personal/obsidian/brain-log";

          community-plugins = {
            # List of plugin names translate to vault/.obsidian/community-plugins.json:
            # [ "plugin-1", "plugin-2" ]

            heatmap-calendar.enable = true;
            obsidian-git.enable = true;
            obsidian-importer.enable = true;
            iconic.enable = true;
            obsidian-vimrc-support.enable = true;
            templater-obsidian.enable = true;
            dataview.enable = true;
            obsidian-tasks-plugin.enable = true;
            calendar.enable = true;
            obsidian-kanban.enable = true;
            editing-toolbar.enable = true;
            url-into-selection.enable = true;
            dbfolder.enable = true;
            obsidian-media-db-plugin.enable = true;
            obsidian-read-it-later.enable = true;
            obsidian-icon-folder.enable = true;

            obsidian-style-settings = {
              enable = true;
              config = {
                # Configuration in here would translate to
                # vault/.obsidian/plugins/obsidian-style-settings/data.json
              };
            };
          };

          core-plugins = {
            # Format in vault/.obsidian/core-plugins.json is different:
            # { "plugin-1": true, "plugin-2": false }

            file-explorer = {
              enable = true;
              # config = {
              # Configuration here would translate to
              # vault/.obsidian/plugins/file-explorer/data.json
              # };
            };
            daily-notes = {
              enable = true;
              config = {
                folder = "daily-note";
                template = "template/daily_note";
                format = "YYYY-MM-DD-dddd";
              };
            };
            global-search.enable = true;
            switcher.enable = true;
            graph.enable = true;
            backlink.enable = true;
            canvas.enable = true;
            outgoing-link.enable = true;
            tag-pane.enable = true;
            properties.enable = false;
            page-preview.enable = true;
            templates.enable = true;
            note-composer.enable = true;
            command-palette.enable = true;
            slash-command.enable = true;
            editor-status.enable = true;
            bookmarks.enable = true;
            markdown-importer.enable = false;
            zk-prefixer.enable = false;
            random-note.enable = false;
            outline.enable = true;
            word-count.enable = true;
            slides.enable = false;
            audio-recorder.enable = false;
            workspaces.enable = false;
            file-recovery.enable = true;
            publish.enable = false;
            sync.enable = false;
            webviewer.enable = false;
          };

          extraConfig = {
            app = {
              # Directly translates to vault/.obsidian/app.json
            };
            appearance = {
              # Directly translates to vault/.obsidian/appearance.json
            };
            # etc.
          };
        };
      };
    };

  };
}
