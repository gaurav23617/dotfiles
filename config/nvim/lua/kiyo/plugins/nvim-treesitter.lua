return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },

        -- ensure these languages parsers are installed
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "go",
          "yaml",
          "html",
          "css",
          "python",
          "http",
          "prisma",
          "markdown",
          "markdown_inline",
          "svelte",
          "graphql",
          "bash",
          "php",
          "phpdoc",
          "blade",
          "lua",
          "nix",
          "vim",
          "dockerfile",
          "gitignore",
          "query",
          "vimdoc",
          "c",
          "java",
          "rust",
          "ron",
          "terraform",
          "hcl",
          "nu",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
          },
        },
        additional_vim_regex_highlighting = false,
      })
      local function add(lang)
        local parsers = treesitter.ensure_installed or {}
        if type(parsers) == "table" then
          table.insert(parsers, lang)
        end
      end

      vim.filetype.add({
        extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
        filename = { ["vifmrc"] = "vim" },
        pattern = {
          [".*/waybar/config"] = "jsonc",
          [".*/mako/config"] = "dosini",
          [".*/kitty/.+%.conf"] = "kitty",
          [".*/hypr/.+%.conf"] = "hyprlang",
          ["%.env%.[%w_.-]+"] = "sh",
        },
      })

      vim.treesitter.language.register("bash", "kitty")

      add("git_config")

      if vim.fn.executable("hypr") == 1 then
        add("hyprlang")
      end

      if vim.fn.executable("fish") == 1 then
        add("fish")
      end

      if vim.fn.executable("rofi") == 1 or vim.fn.executable("wofi") == 1 then
        add("rasi")
      end
    end,
  },
  -- NOTE: js,ts,jsx,tsx Auto Close Tags
  {
    "windwp/nvim-ts-autotag",
    enabled = true,
    ft = {
      "html",
      "xml",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
    },
    config = function()
      -- Independent nvim-ts-autotag setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true, -- Auto-close tags
          enable_rename = true, -- Auto-rename pairs
          enable_close_on_slash = false, -- Disable auto-close on trailing `</`
        },
        per_filetype = {
          ["html"] = {
            enable_close = true, -- Disable auto-closing for HTML
          },
          ["typescriptreact"] = {
            enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
          },
        },
      })
    end,
  },
}
