return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_next = "<c-j>",
          jump_prev = "<c-k>",
          accept = "<c-a>",
          refresh = "r",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4,
        },
      },
      filetypes = {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<c-a>",
            accept_word = false,
            accept_line = false,
            next = "<c-j>",
            prev = "<c-k>",
            dismiss = "<C-e>",
          },
        },
        markdown = true,
        help = true,
        lua = true,
        javascript = true,
        typescript = true,
        python = true,
        css = true,
        html = true,
      },
      auto_start = true,
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      -- AI Accept Action
      vim.api.nvim_create_user_command("CopilotAccept", function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.accept()
        end
      end, {})

      -- Map Copilot Accept to <M-l>
      vim.keymap.set("i", "<M-l>", function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.accept()
        end
      end, { desc = "Accept Copilot Suggestion" })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
