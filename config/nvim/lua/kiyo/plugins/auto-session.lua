return {
  "rmagatti/auto-session",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore = false,
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
    keymap.set(
      "n",
      "<leader>ws",
      "<cmd>SessionSave<CR>",
      { desc = "Save session for auto session root dir" }
    ) -- save workspace session for current working directory
  end,
}
