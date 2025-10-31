return {
  { "echasnovski/mini.nvim", version = false, lazy = true },
  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
  },
  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          g = { -- Buffer text object without LazyVim
            a = "^[^%s]+$", -- whole buffer content
            i = "^[^%s]+$", -- inner buffer content
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 300,

      -- Module mappings. Use `''` (empty string) to disable one.
      -- INFO:
      -- saiw surround with no whitespace
      -- saw surround with whitespace
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = "cover",

      -- Whether to disable showing non-error feedback
      silent = false,
      keys = {
        { "sr", "", desc = "+surround" },
      },
    },
  },
  {
    "echasnovski/mini.trailspace",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local miniTrailspace = require("mini.trailspace")

      miniTrailspace.setup({
        only_in_normal_buffers = true,
      })
      vim.keymap.set("n", "<leader>cw", function()
        miniTrailspace.trim()
      end, { desc = "Erase Whitespace" })

      -- Ensure highlight never reappears by removing it on CursorMoved
      vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*",
        callback = function()
          require("mini.trailspace").unhighlight()
        end,
      })
    end,
  },
  {
    "echasnovski/mini.files",
    event = "VeryLazy",
    config = function()
      local MiniFiles = require("mini.files")
      MiniFiles.setup({
        mappings = {
          go_in = "<CR>", -- Map both Enter and L to enter directories or open files
          go_in_plus = "L",
          go_out = "-",
          go_out_plus = "H",
        },
      })
      vim.keymap.set(
        "n",
        "<leader>ee",
        "<cmd>lua MiniFiles.open()<CR>",
        { desc = "Toggle mini file explorer" }
      ) -- toggle file explorer
      vim.keymap.set("n", "<leader>ef", function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        MiniFiles.reveal_cwd()
      end, { desc = "Toggle into currently opened file" })
    end,
  },
  {
    "echasnovski/mini.move",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.move").setup({
        -- module mappings. use `''` (empty string) to disable one.
        mappings = {
          -- move visual selection in visual mode. defaults are alt (meta) + hjkl.
          left = "<m-h>",
          right = "<m-l>",
          down = "<m-j>",
          up = "<m-k>",

          -- move current line in normal mode
          line_left = "<m-h>",
          line_right = "<m-l>",
          line_down = "<m-j>",
          line_up = "<m-k>",
        },

        -- options which control moving behavior
        options = {
          -- automatically reindent selection during linewise vertical move
          reindent_linewise = true,
        },
      })
    end,
  },
}
