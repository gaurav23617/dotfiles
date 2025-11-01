return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true }, function(err, did_edit)
          if not err and did_edit then
            vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      -- Go
      go = { "goimports", "gofmt" },
      -- Lua
      lua = { "stylua" },
      -- Web technologies - Using biome for JS/TS/JSON
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },
      nix = { "alejandra" },
      -- Other webtechnologies that biome doesn't support
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      -- Python
      python = { "isort", "black" },
      -- PHP/Laravel
      php = { "pint" },
      blade = { "blade-formatter" },
      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
      -- Other (system tools)
      rust = { "rustfmt" },
      hcl = { "packer_fmt" },
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
      ["terraform-vars"] = { "terraform_fmt" },
      -- toml = { "taplo" },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
