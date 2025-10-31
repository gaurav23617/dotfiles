return {
  "L3MON4D3/LuaSnip",
  event = { "InsertEnter" },
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local luasnip = require("luasnip")

    -- Load friendly-snippets & custom snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })

    -- Extend JavaScript snippets
    luasnip.filetype_extend("javascript", { "jsdoc" })

    -- Prevent error on expand if no snippet is available
    vim.keymap.set({ "i" }, "<C-s>e", function()
      if luasnip.expandable() then
        luasnip.expand()
      end
    end, { silent = true })

    -- Improved Tab Navigation for Snippets
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        -- If no snippet, insert a normal tab character
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", false)
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        -- If no snippet, insert a normal reverse tab
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true),
          "n",
          false
        )
      end
    end, { silent = true })

    -- Change snippet choice if applicable
    vim.keymap.set({ "i", "s" }, "<C-E>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true })
  end,
}
