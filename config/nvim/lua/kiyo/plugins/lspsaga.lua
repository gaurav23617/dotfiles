return {
  "nvimdev/lspsaga.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
  opts = {
    ui = {
      code_action = "",
    },
    symbol_in_winbar = {
      enable = true,
      separator = "| ",
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
      respect_root = false,
      color_mode = true,
    },
    outline = {
      win_position = "botright",
      win_with = "",
      win_width = 30,
      show_detail = true,
      auto_preview = true,
      auto_refresh = true,
      auto_close = true,
      custom_sort = nil,
      keys = {
        jump = "o",
        expand_collapse = "u",
        quit = "q",
      },
    },
  },
  keys = {
    { "n", "gd", "<cmd>Lspsaga goto_definition<CR>" },
    { "n", "<leader>ln", "<cmd>Lspsaga rename ++project<CR>" },
    { "n", "K", "<cmd>Lspsaga hover_doc<CR>" },
    { "n", "t", "<cmd>Lspsaga term_toggle" },
  },
}
