return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    -- Disable default mappings except for <C-n>
    vim.g.VM_default_mappings = 0
    vim.g.VM_mouse_mappings = 0

    -- Custom Key Mappings
    vim.g.VM_maps = {
      ["Find Under"] = "<C-S-d>", -- Find and add cursor under
      ["Find Subword Under"] = "<C-S-n>", -- Find subword
      ["Select h"] = "<S-h>", -- Select left
      ["Select l"] = "<S-l>", -- Select right
      ["Toggle Mappings"] = "\\", -- Toggle multi-cursor mode
      ["Select All"] = "<C-S-a>", -- Select all occurrences
      ["Skip Under"] = "<C-x>", -- Skip current selection
      ["Remove Region"] = "<C-S-x>", -- Remove last added cursor
    }

    -- Extra Behavior Settings
    vim.g.VM_add_cursor_at_post_no_mappings = 1
    vim.g.VM_verbose_commands = 0 -- Hide verbose messages
    vim.g.VM_silent_exit = 1 -- No message when exiting
    vim.g.VM_quit_after_leaving_insert_mode = 1 -- Auto quit VM mode
  end,

  config = function()
    -- Function to properly handle plugin commands
    VMFunc = function(FunKey)
      local key = vim.api.nvim_replace_termcodes(FunKey, true, true, true)
      vim.api.nvim_feedkeys(key, "n", false)
    end

    -- Key Mappings for Multi-Cursor
    vim.keymap.set(
      "n",
      "<C-b>",
      [[:lua VMFunc('<Plug>(VM-Add-Cursor-At-Pos)')<CR>]],
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<C-k>",
      [[:lua VMFunc('<Plug>(VM-Add-Cursor-Down)')<CR>]],
      { silent = true }
    )
    vim.keymap.set("n", "<C-j>", [[:lua VMFunc('<Plug>(VM-Add-Cursor-Up)')<CR>]], { silent = true })
    vim.keymap.set("n", "<C-n>", [[:lua VMFunc('<Plug>(VM-Find-Under)')<CR>]], { silent = true })
    vim.keymap.set("n", "<C-S-n>", [[:lua VMFunc('<Plug>(VM-Select-All)')<CR>]], { silent = true })
    vim.keymap.set("n", "<C-x>", [[:lua VMFunc('<Plug>(VM-Remove-Cursor)')<CR>]], { silent = true })
    vim.keymap.set(
      "n",
      "<C-S-x>",
      [[:lua VMFunc('<Plug>(VM-Remove-Region)')<CR>]],
      { silent = true }
    )
  end,
}
