return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      -- Remove tools that Nix provides
      ensure_installed = {
        -- LSP servers (matching your vim.lsp.enable() config)
        "lua-language-server", -- Lua LSP
        "gopls", -- Go LSP
        "zls", -- Zig LSP
        "typescript-language-server", -- TypeScript LSP
        "rust-analyzer", -- Rust LSP
        -- "intelephense", -- PHP LSP
        "tailwindcss-language-server", -- Tailwind CSS LSP
        "html-lsp", -- HTML LSP
        "css-lsp", -- CSS LSP
        "vue-language-server", -- Vue LSP
        "biome",
        "nil",
        "alejandra",
        "tflint",

        -- Formatters (for conform.nvim and general use)
        "stylua",
        "selene",
        "goimports",
        -- Note: gofmt comes with Go installation, not managed by Mason
        "prettier",
        -- "black",
        -- "isort",
        "blade-formatter",

        -- Linters and diagnostics
        "golangci-lint",
        "eslint_d",
        "luacheck", -- Lua linting
        -- "pint", -- Laravel Pint for PHP (formatting & linting)

        -- Additional useful tools
        "delve", -- Go debugger
        "shfmt", -- Shell formatter
        "shellcheck", -- Shell linter

        -- Optional but useful additions
        -- "markdownlint", -- Markdown linting
        -- "yamllint",     -- YAML linting
        -- "jsonlint",     -- JSON linting
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- Simplified auto-install without Nix-managed tools
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          if mr.has_package(tool) then
            local p = mr.get_package(tool)
            if not p:is_installed() then
              vim.notify("Mason: Installing " .. tool .. "...", vim.log.levels.INFO)
              p:install()
            end
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
