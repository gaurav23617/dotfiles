return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- Load immediately
  priority = 500, -- Ensure it loads before other plugins
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    integrations = {
      aerial = true,
      cmp = true,
      blink_cmp = true,
      flash = true,
      fzf = true,
      grug_far = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      snacks = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
  config = function()
    vim.cmd.colorscheme("catppuccin") -- Apply the colorscheme
  end,
}
