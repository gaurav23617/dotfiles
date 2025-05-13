-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Optimizations on startup
vim.loader.enable()

-- Enable this option to avoid conflicts with Prettier.
vim.g.lazyvim_prettier_needs_config = true

vim.g.lazyvim_blink_main = true
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_autoformat = false
vim.g.lazyvim_cmp = "blink"

-- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = true
