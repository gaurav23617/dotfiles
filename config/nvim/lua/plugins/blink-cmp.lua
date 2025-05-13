return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-dictionary",
  },
  opts = {
    sources = {
      default = {
        "dictionary",
      },
      providers = {
        dictionary = {
          name = "Dict",
          module = "blink-cmp-dictionary",
          score_offset = 20,
          enabled = true,
          max_items = 8,
          min_keyword_length = 3,
          opts = {
            dictionary_directories = { vim.fn.expand "~/.config/nvim/dictionaries" },
            dictionary_files = {
              vim.fn.expand "~/.config/nvim/spell/en.utf-8.add",
              vim.fn.expand "~/.config/nvim/spell/es.utf-8.add",
            },
          },
        },
      },
    },
  },
}
