return {
  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  -- Flash enhances the built-in search functionality by showing labels
  -- at the end of each match, letting you quickly jump to a specific
  -- location.
  {
    "folke/flash.nvim",
    event = { "BufReadPre", "BufNewFile" },
    vscode = true,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mbbill/undotree",
    event = { "BufReadPre", "BufNewFile" },
    vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle),
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle),
  },
  {
    "nvim-tree/nvim-web-devicons",
    -- lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "szw/vim-maximizer",
    opts = {},
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },
  {
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    opts = {
      port = 5500,
      browser = "default",
      dynamic_root = false,
      sync_scroll = false,
      picker = "",
    },
  },
  -- Neovim plugin to improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    config = function()
      require("dressing").setup()
    end,
  },
  {
    "shahshlok/vim-coach.nvim",
    cmd = "VimCoach",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      require("vim-coach").setup()
    end,
    keys = {
      { "<leader>?", "<cmd>VimCoach<cr>", desc = "Vim Coach" },
    },
  },

  -- Neovim notifications and LSP progress messages
  -- {
  --   "j-hui/fidget.nvim",
  -- },

  -- Heuristically set buffer options
  -- {
  --   "tpope/vim-sleuth",
  -- },
  -- editor config support
  -- {
  --   "editorconfig/editorconfig-vim",
  -- },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },
}
