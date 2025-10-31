return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local mason_bin_dir = vim.fn.stdpath("data") .. "/mason/bin"

    -- Define golangcilint and pint as you already do (omitted here for brevity)...

    -- Define terraform_validate linter correctly as a table
    lint.linters.terraform_validate = {
      cmd = "terraform",
      stdin = false,
      args = { "validate", "-no-color" },
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        if not output or output == "" then
          return diagnostics
        end
        -- Parse terraform validate output for errors and warnings
        for line in output:gmatch("[^\r\n]+") do
          -- simple pattern for file:line:col: message (adapt if needed)
          local file, lnum, col, msg = line:match("([^:]+):(%d+):(%d+): (.+)")
          if lnum and msg then
            table.insert(diagnostics, {
              lnum = tonumber(lnum) - 1,
              col = tonumber(col) - 1,
              message = msg,
              severity = vim.diagnostic.severity.ERROR,
              source = "terraform_validate",
            })
          elseif line:find("Error") or line:find("Warning") then
            table.insert(diagnostics, {
              lnum = 0,
              col = 0,
              message = line,
              severity = vim.diagnostic.severity.ERROR,
              source = "terraform_validate",
            })
          end
        end
        return diagnostics
      end,
    }

    -- Your biome, pint, golangcilint configs continue here...

    lint.linters_by_ft = {
      go = { "golangcilint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      lua = { "luacheck" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      php = { "pint" },
      terraform = { "terraform_validate" },
      tf = { "terraform_validate" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        local linters = lint.linters_by_ft[vim.bo.filetype]
        if linters and #linters > 0 then
          for _, linter_name in ipairs(linters) do
            local linter = lint.linters[linter_name]
            if linter then
              if type(linter) == "table" then
                local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
                if vim.fn.executable(cmd) == 1 then
                  lint.try_lint(linter_name)
                  break
                else
                  vim.notify(
                    "Linter '" .. linter_name .. "' not found: " .. cmd,
                    vim.log.levels.WARN
                  )
                end
              else
                vim.notify(
                  "Linter '" .. linter_name .. "' is not a table but a " .. type(linter),
                  vim.log.levels.ERROR
                )
              end
            end
          end
        end
      end,
    })

    -- Keymaps for manual linting etc. remain as in your existing config
  end,
}
