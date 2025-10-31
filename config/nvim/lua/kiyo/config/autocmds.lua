local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General autocommands
local general = augroup("General", { clear = true })

-- don't auto comment new line
autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- wrap words "softly" (no carriage return) in mail buffer
autocmd("Filetype", {
  pattern = "mail",
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = "80"
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- auto close brackets
-- this
autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- Enable spell checking for certain file types
autocmd(
  { "BufRead", "BufNewFile" },
  -- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
  {
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
      vim.opt.spell = true
      vim.opt.spelllang = "en"
    end,
  }
)

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command("autocmd VimResized * wincmd =")

-- fix terraform and hcl comment string
autocmd("FileType", {
  group = augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})

autocmd("LspAttach", {
  group = augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")

    map(
      "<leader>v",
      "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",
      "Goto Definition in Vertical Split"
    )

    local wk = require("which-key")
    wk.add({
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
      {
        "<leader>lA",
        vim.lsp.buf.range_code_action,
        desc = "Range Code Actions",
      },
      {
        "<leader>ls",
        vim.lsp.buf.signature_help,
        desc = "Display Signature Information",
      },
      {
        "<leader>lr",
        vim.lsp.buf.rename,
        desc = "Rename all references",
      },
      { "<leader>lf", vim.lsp.buf.format, desc = "Format" },
      {
        "<leader>lc",
        require("kiyo.config.utils").copyFilePathAndLineNumber,
        desc = "Copy File Path and Line Number",
      },
      {
        "<leader>Wa",
        vim.lsp.buf.add_workspace_folder,
        desc = "Workspace Add Folder",
      },
      {
        "<leader>Wr",
        vim.lsp.buf.remove_workspace_folder,
        desc = "Workspace Remove Folder",
      },
      {
        "<leader>Wl",
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = "Workspace List Folders",
      },
    })

    local function client_supports_method(client, method, bufnr)
      if vim.fn.has("nvim-0.11") == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client_supports_method(
        client,
        vim.lsp.protocol.Methods.textDocument_documentHighlight,
        event.buf
      )
    then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if
      client
      and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
    then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Remove trailing whitespace",
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = general,
  pattern = "*",
  command = "wincmd =",
  desc = "Auto-resize splits",
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
  desc = "Return to last edit position",
})

-- Create directories when saving a file if they don't exist
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto-create directories",
})

autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "query",
    "",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd("quit")
  end,
})

autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd("checktime")
  end,
})

autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    local dirname = vim.fn.getcwd():match("([^/]+)$")
    vim.opt.titlestring = dirname
  end,
})

autocmd({ "TextYankPost" }, {
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 40 })
  end,
})

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd([[silent! lua require("luasnip").unlink_current()]])
    end
  end,
})

autocmd("BufWinLeave", {
  pattern = "?*", -- Avoid running for unnamed buffers
  callback = function()
    if vim.fn.empty(vim.fn.expand("%")) == 0 then -- Check if file has a name
      vim.cmd("silent! mkview")
    end
  end,
})

autocmd("BufWinEnter", {
  pattern = "?*", -- Avoid running for unnamed buffers
  callback = function()
    if vim.fn.empty(vim.fn.expand("%")) == 0 and vim.fn.filereadable(vim.fn.expand("%:p")) == 1 then
      vim.cmd("silent! loadview")
    end
  end,
})
