local blink = require("blink.cmp")

---@type vim.lsp.Config
return {
  cmd = { "prisma-language-server", "--stdio" },
  root_markers = { ".git", "package.json" },
  filetypes = { "prisma" },
}
