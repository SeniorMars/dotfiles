local api = vim.api

local group = api.nvim_create_augroup("Random", { clear = true })

-- Restore cursor to file position in previous editing session.
api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(args)
    local mark = api.nvim_buf_get_mark(args.buf, '"')
    local line_count = api.nvim_buf_line_count(args.buf)

    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
  desc = "Restore cursor position",
})

-- Close utility buffers with q or Esc.
api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "help",
    "qf",
    "checkhealth",
    "vim",
    "fugitive",
    "lazy",
  },
  callback = function(args)
    local bufnr = args.buf

    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = bufnr,
      silent = true,
      nowait = true,
      desc = "Close buffer",
    })

    vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", {
      buffer = bufnr,
      silent = true,
      nowait = true,
      desc = "Close buffer",
    })

    vim.bo[bufnr].buflisted = false
  end,
  desc = "Close utility buffers with q or Esc",
})

api.nvim_create_autocmd("VimResized", {
  group = group,
  desc = "Keep windows equally resized",
  command = "tabdo wincmd =",
})

api.nvim_create_autocmd("TermOpen", {
  group = group,
  desc = "Disable line numbers in terminal buffers",
  command = "setlocal nonumber norelativenumber signcolumn=no",
})

api.nvim_create_autocmd("InsertEnter", {
  group = group,
  desc = "Use shorter timeoutlen in insert mode",
  command = "set timeoutlen=100",
})

api.nvim_create_autocmd("InsertLeave", {
  group = group,
  desc = "Restore timeoutlen outside insert mode",
  command = "set timeoutlen=1000",
})
