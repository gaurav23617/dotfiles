return {
  "m4xshen/hardtime.nvim",
  -- lazy = true,
  enabled = true,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    restricted_keys = {
      ["j"] = false,
      ["k"] = false,
      -- optional: also unrestrict wrapped-line moves
      ["gj"] = false,
      ["gk"] = false,
    },
  },
}
