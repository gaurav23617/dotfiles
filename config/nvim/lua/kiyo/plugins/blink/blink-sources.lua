return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      default = {
        -- "dictionary",
        "lazydev",
        "copilot",
        "lsp",
        "path",
        "snippets",
        "ripgrep",
        "buffer",
      },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          min_keyword_length = 2,
          score_offset = 15,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        ripgrep = {
          name = "ripgrep",
          module = "blink-ripgrep",
          score_offset = 30,
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets", "buffer" },
          min_keyword_length = 2,
        },
        buffer = {
          opts = {
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
          },
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 4,
          score_offset = 15,
        },
        snippets = {
          name = "snippets",
          enabled = true,
          max_items = 15,
          min_keyword_length = 2,
          module = "blink.cmp.sources.snippets",
          score_offset = 30,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        -- dictionary = {
        --   name = "Dict",
        --   module = "blink-cmp-dictionary",
        --   score_offset = 20,
        --   enabled = true,
        --   max_items = 8,
        --   min_keyword_length = 3,
        --   opts = {
        --     dictionary_directories = { vim.fn.expand("~/.config/nvim/dictionaries") },
        --     dictionary_files = {
        --       vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
        --       vim.fn.expand("~/.config/nvim/spell/es.utf-8.add"),
        --     },
        --   },
        -- },
      },
    },
  },
}
