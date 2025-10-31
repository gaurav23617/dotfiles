-- Helper
local function keymap(mode, keys, action, desc)
  local opts = { noremap = true, silent = true, desc = desc or "" }
  vim.keymap.set(mode, keys, action, opts)
end

-- Insert mode exit
keymap("i", "jj", "<ESC>", "Exit insert mode with jj")
keymap("i", "jk", "<ESC>:w<CR>", "Exit insert mode and save")

-- Save / Quit
keymap("n", "<leader>w", "<cmd>w<CR>", "Save file")
keymap("n", "<leader>ss", "<cmd>w<CR>", "Save file")
keymap("n", "<leader>wq", "<cmd>wq<CR>", "Save and quit")
keymap("n", "<leader>wqa", "<cmd>wqa<CR>", "Save all and quit")
keymap("n", "<leader>q", "<cmd>q<CR>", "Quit current")
keymap("n", "<leader>qq", "<cmd>qa<CR>", "Quit all")

-- Clear search
keymap("n", "<Esc>", ":nohlsearch<CR>", "Clear highlights")
keymap("n", "<leader>nh", ":nohl<CR>", "Clear highlights")

-- Centered scrolling
-- keymap("n", "<C-d>", "<C-d>zz", "Scroll down and center")
-- keymap("n", "<C-u>", "<C-u>zz", "Scroll up and center")

-- Visual movement
keymap("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
keymap("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")

-- Buffers
keymap("n", "<S-h>", "<cmd>bprevious<cr>", "Prev Buffer")
keymap("n", "<S-l>", "<cmd>bnext<cr>", "Next Buffer")
keymap("n", "[b", "<cmd>bprevious<cr>", "Prev Buffer")
keymap("n", "]b", "<cmd>bnext<cr>", "Next Buffer")
keymap("n", "<leader>bb", "<cmd>e #<cr>", "Switch to Other Buffer")
keymap("n", "<leader>`", "<cmd>e #<cr>", "Switch to Other Buffer")
keymap("n", "<leader>bd", function()
  Snacks.bufdelete()
end, "Delete Buffer")
keymap("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, "Delete Other Buffers")
keymap("n", "<leader>bD", "<cmd>bd<cr>", "Delete Buffer and Window")

-- Line wrap-aware navigation
-- keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", "Smart down")
-- keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", "Smart up")

-- Better indenting
keymap("v", "<", "<gv", "Indent left")
keymap("v", ">", ">gv", "Indent right")

-- Paste without yanking
keymap({ "v", "x" }, "p", "P", "Paste without yank")
-- keymap("v", "P", '"_dP', "Paste before without yank")

-- Yank inside {}
keymap("n", "YY", "va{Vy", "Yank inside braces")

-- Exit insert with save
keymap("i", "jk", "<ESC>:w<CR>", "Save & exit insert")

-- Start / end of line
keymap({ "n", "x", "o" }, "H", "^", "Start of line")
keymap({ "n", "x", "o" }, "L", "g_", "End of line")

-- Pane resize
keymap("n", "+", ":vertical resize +5<CR>", "Increase pane width")
keymap("n", "_", ":vertical resize -5<CR>", "Decrease pane width")
keymap("n", "=", ":resize +5<CR>", "Increase pane height")
keymap("n", "-", ":resize -5<CR>", "Decrease pane height")

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", "Move left")
keymap("n", "<C-j>", "<C-w>j", "Move down")
keymap("n", "<C-k>", "<C-w>k", "Move up")
keymap("n", "<C-l>", "<C-w>l", "Move right")

-- Window resizing with arrows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", "Resize + height")
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", "Resize - height")
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", "Resize - width")
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", "Resize + width")

-- Tabs
keymap("n", "<leader>to", "<cmd>tabnew<CR>", "New tab")
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", "Close tab")
keymap("n", "<leader>tn", "<cmd>tabn<CR>", "Next tab")
keymap("n", "<leader>tp", "<cmd>tabp<CR>", "Prev tab")
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", "Open current buffer in new tab")

-- Splits
keymap("n", "<leader>sv", "<C-w>v", "Vertical split")
keymap("n", "<leader>sh", "<C-w>s", "Horizontal split")
keymap("n", "<leader>se", "<C-w>=", "Equal split size")
keymap("n", "<leader>sx", "<cmd>close<CR>", "Close split")

-- Increment / Decrement
keymap("n", "<leader>+", "<C-a>", "Increment number")
keymap("n", "<leader>-", "<C-x>", "Decrement number")

-- Search centering
-- keymap("n", "n", "nzzv", "Next match centered")
-- keymap("n", "N", "Nzzv", "Prev match centered")
keymap("n", "*", "*zzv", "Search word forward")
keymap("n", "#", "#zzv", "Search word backward")
keymap("n", "g*", "g*zz", "Partial search forward")
keymap("n", "g#", "g#zz", "Partial search backward")

-- Cut full line
keymap("n", "<C-x>", "dd", "Cut line")

-- New file in same dir
keymap("n", "<C-n>", ":w %:h/", "Write to new file in dir")

-- Telescope (commented, enable if needed)
-- keymap("n", "<C-s>", ":Telescope current_buffer_fuzzy_find<CR>", "Search in buffer")
-- keymap("n", ";", "<cmd>Telescope resume<cr>", "Resume Telescope")

-- Line split with `X`
keymap(
  "n",
  "X",
  ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>",
  "Split line at cursor"
)

-- Buffer navigation
keymap("n", "<Right>", ":bnext<CR>", "Next buffer")
keymap("n", "<Left>", ":bprevious<CR>", "Previous buffer")

-- Custom utils
keymap("n", "<C-P>", ':lua require("kiyo.config.utils").toggle_go_test()<CR>', "Toggle Go Test")
keymap(
  "v",
  "<leader>ln",
  ':lua require("kiyo.config.utils").get_highlighted_line_numbers()<CR>',
  "Get visual line numbers"
)

-- Plugin shortcuts
keymap("n", "<leader>pl", "<cmd>Lazy<CR>", "Open Lazy")
keymap("n", "<leader>pi", "<cmd>Lazy install<CR>", "Lazy install")
keymap("n", "<leader>pu", "<cmd>Lazy update<CR>", "Lazy update")
keymap("n", "<leader>pm", "<cmd>Mason<CR>", "Mason")
keymap("n", "<leader>pmu", "<cmd>MasonUpdate<CR>", "Mason update")

-- Change inner word with Enter / Backspace
keymap("n", "<CR>", "ciw", "Change word (Enter)")
keymap("n", "<BS>", "ci", "Change inside (Backspace)")

keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
keymap("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
keymap("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
keymap("n", "<M-s>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")
