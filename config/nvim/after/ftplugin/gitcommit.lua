vim.opt_local.linebreak = true -- Break lines at word boundaries
vim.opt_local.modifiable = true
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "yes:1"
vim.opt_local.textwidth = 0 -- Disable text width
vim.opt_local.wrap = true -- Enable line wrapping

local keymap = vim.keymap.set
local opts = { buffer = 0 }

local function accept_commit_message()
  vim.cmd("%s/^\\s*//g") -- trim leading whitespace(s)
  vim.cmd("wq")
end

keymap({ "n", "i" }, "<c-s>", accept_commit_message, opts)
keymap({ "n", "i" }, "<leader>ac", ":CopilotCommitMessage<cr>", opts)
keymap({ "n" }, "<esc>", "", opts) -- Disable <esc> as it closes the buffer
keymap({ "n", "i" }, "<c-q>", ":q!<cr>", opts) -- Close the buffer
