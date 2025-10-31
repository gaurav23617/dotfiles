return {
  "saghen/blink.cmp",
  event = { "InsertEnter" },
  version = "*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./luasnip_snippets" } })
      end,
    },
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      version = "*",
      opts = {},
    },
    "neovim/nvim-lspconfig",
    -- "Kaiser-Yang/blink-cmp-dictionary",
    "folke/lazydev.nvim",
    "fang2hou/blink-copilot",
    "mikavilpas/blink-ripgrep.nvim",
    "folke/snacks.nvim",
  },
  opts = {
    fuzzy = {},
    keymap = {},
    appearance = {},
    completion = {},
    cmdline = {},
    term = {},
    snippets = {},
    sources = {},
  },
  config = function(_, opts)
    -- Ensure compatibility sources are enabled
    local enabled = opts.sources.default or {}
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    -- Add AI accept to <Tab> key
    if not opts.keymap["<Tab>"] then
      if opts.keymap.preset == "super-tab" then
        opts.keymap["<Tab>"] = {
          require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
          { "snippet_forward", "ai_accept" },
          "fallback",
        }
      else
        opts.keymap["<Tab>"] = {
          { "snippet_forward", "ai_accept" },
          "fallback",
        }
      end
    end
    require("blink.cmp").setup(opts)
  end,
}
