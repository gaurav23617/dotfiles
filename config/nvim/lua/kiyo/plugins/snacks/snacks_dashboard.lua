return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = ":lua Snacks.dashboard.pick('files')",
          },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      -- item field formatters
      formats = {
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
      },
      -- sections = {
      -- 	{ section = "header", align = "center", padding = 2 },
      -- 	{ section = "keys", gap = 1, padding = 1 },
      -- 	{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      -- 	{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      -- 	{
      -- 		pane = 2,
      -- 		icon = " ",
      -- 		title = "Git Status",
      -- 		section = "terminal",
      -- 		enabled = function()
      -- 			return Snacks.git.get_root() ~= nil
      -- 		end,
      -- 		cmd = "git status --short --branch --renames",
      -- 		height = 5,
      -- 		padding = 2,
      -- 		ttl = 5 * 60,
      -- 		indent = 3,
      -- 	},
      -- 	{ section = "startup" },
      -- },
    },
  },
}
