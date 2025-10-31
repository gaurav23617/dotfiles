return {
  "saghen/blink.cmp",
  opts = {
    snippets = {
      preset = "luasnip",
      expand = function(snippet)
        vim.snippet.expand(snippet)
      end,
      active = function(filter)
        return vim.snippet.active(filter)
      end,
      jump = function(direction)
        vim.snippet.jump(direction)
      end,
    },
  },
}
