return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      -- Remove tools that Nix provides
      ensure_installed = {
        -- Keep only platform-specific tools Mason should manage
        -- Remove: lua-language-server, gopls, nil, nixfmt, luacheck, pint

        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "vue-language-server",
        "biome",
        "eslint_d",
        "prettier",
        "blade-formatter",
        "shfmt",
        "shellcheck",
        "delve",

        -- Add comment explaining why some are excluded:
        -- Note: lua-language-server, gopls, rust-analyzer, nil, nixfmt,
        -- luacheck, cargo, composer are provided by Nix
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
