vim.lsp.config('dafny', {
  cmd = { "dafny", "server" },
  filetypes = { "dafny", "dfy" },
  root_markers = { ".git" },
})

vim.lsp.enable('dafny')
