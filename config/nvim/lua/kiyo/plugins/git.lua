return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      -- local icons = require('config.icons')
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 5000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        -- yadm = { enable = false },

        on_attach = function(bufnr)
          vim.keymap.set(
            "n",
            "<leader>H",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "Preview git hunk" }
          )

          vim.keymap.set(
            "n",
            "]]",
            require("gitsigns").next_hunk,
            { buffer = bufnr, desc = "Next git hunk" }
          )

          vim.keymap.set(
            "n",
            "[[",
            require("gitsigns").prev_hunk,
            { buffer = bufnr, desc = "Previous git hunk" }
          )
        end,
      })
    end,
    keys = {
      {
        "<leader>Gk",
        function()
          require("gitsigns").prev_hunk({ navigation_message = false })
        end,
        desc = "Prev Hunk",
      },
      {
        "<leader>Gl",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Blame",
      },
      {
        "<leader>Gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>Gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>GR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer",
      },
      {
        "<leader>Gj",
        function()
          require("gitsigns").next_hunk({ navigation_message = false })
        end,
        desc = "Next Hunk",
      },
      {
        "<leader>Gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "<leader>Gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk",
      },
      -- {
      --   "<leader>Go", require("telescope.builtin").git_status,
      --   desc = "Open changed file"
      -- },
      -- {
      --   "<leader>Gb", require("telescope.builtin").git_branches,
      --   desc = "Checkout branch"
      -- },
      -- {
      --   "<leader>Gc", require("telescope.builtin").git_commits,
      --   desc = "Checkout commit"
      -- },
      -- {
      --   "<leader>GC", require("telescope.builtin").git_bcommits,
      --   desc = "Checkout commit(for current file)"
      -- },
      {
        "<leader>Gd",
        function()
          vim.cmd("Gitsigns diffthis HEAD")
        end,
        desc = "Git Diff HEAD",
      },
    },
  },
  -- Git related plugins
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open DiffView for git" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close DiffView for git" },
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {},
    keys = {
      { "<leader>gnn", "<cmd>Neogit<cr>", desc = "Neogit (Root Dir)" },
      { "<leader>gnc", "<cmd>Neogit commit<cr>", desc = "Commit" },
      { "<leader>gnp", "<cmd>Neogit pull<cr>", desc = "Pull" },
      { "<leader>gnP", "<cmd>Neogit push<cr>", desc = "Push" },
      { "<leader>gnf", "<cmd>Neogit fetch<cr>", desc = "Fetch" },
    },
  },
}
