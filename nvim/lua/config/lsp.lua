vim.lsp.config('dafny', {
  cmd = { "dafny", "server" },
  filetypes = { "dafny", "dfy" },
  root_markers = { ".git" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable('dafny')
