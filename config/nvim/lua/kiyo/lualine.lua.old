return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    { "AndreM222/copilot-lualine" },
    { "folke/noice.nvim", opts = {} },
  },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- Function to get the root directory name with a fixed color
    local function root_dir()
      return {
        function()
          local cwd = vim.fn.getcwd()
          return "󱉭 " .. vim.fn.fnamemodify(cwd, ":t")
        end,
        color = { fg = "#16bc40" },
      }
    end

    -- Function to format file paths nicely
    local function pretty_path()
      return function()
        local path = vim.fn.expand("%:p")
        if path == "" then
          return ""
        end

        local cwd = vim.fn.getcwd()
        if path:find(cwd, 1, true) == 1 then
          path = path:sub(#cwd + 2)
        end

        local parts = vim.split(path, "[\\/]")
        if #parts > 3 then
          parts = { parts[1], "…", unpack(parts, #parts - 2, #parts) }
        end

        return table.concat(parts, "/")
      end
    end

    -- Ensure lazy.status exists before calling it
    local lazy_updates = function()
      local ok, lazy_status = pcall(require, "lazy.status")
      return ok and lazy_status.updates() or ""
    end
    local lazy_has_updates = function()
      local ok, lazy_status = pcall(require, "lazy.status")
      return ok and lazy_status.has_updates()
    end

    local lazy_status = require("lazy.status")
    local noice = require("noice")

    -- Function to display macro recording status
    local function macro_recording()
      local recording_register = vim.fn.reg_recording()
      return recording_register ~= "" and ("Recording @" .. recording_register) or ""
    end

    -- Function to get Copilot status
    local function copilot_status()
      if not package.loaded["copilot"] then
        return " "
      end

      local clients = vim.lsp.get_clients({ name = "copilot" })
      if #clients == 0 then
        return " "
      end

      local copilot = require("copilot.api").status.data
      if copilot and copilot.status then
        local status = copilot.status
        local icons = {
          ["InProgress"] = " ", -- Spinner
          ["Warning"] = " ", -- Warning
          ["Error"] = " ", -- Error
          ["Unknown"] = " ", -- Unknown
          ["Normal"] = " ", -- Active
        }
        return icons[status]
      end
      return " "
    end

    return {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { "mode", icon = " " },
        },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_c = {
          root_dir(),
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { pretty_path() },
        },
        lualine_x = {
          {
            function()
              return noice.api.status.command.get()
            end,
            cond = function()
              return noice.api.status.command.has()
            end,
            color = { fg = "#cdd6f4" },
          },
          {
            macro_recording,
            cond = function()
              return vim.fn.reg_recording() ~= ""
            end,
            color = { fg = "#ff0000" },
          },
          {
            lazy_updates,
            cond = lazy_has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            copilot_status,
            color = function()
              local copilot = package.loaded["copilot"] and require("copilot.api").status.data
              if copilot and copilot.status then
                local status = copilot.status
                return {
                  fg = (status == "InProgress" and "#FFB86C")
                    or (status == "Warning" and "#FF5555")
                    or "#50FA7B",
                }
              end
              return { fg = "#6272A4" }
            end,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "neo-tree", "lazy", "fzf", "quickfix", "fugitive" },
    }
  end,
}
