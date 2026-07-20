local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("dafny", {
  cmd = { "dafny", "server" },
  filetypes = { "dafny", "dfy" },
  root_markers = { ".git" },
  capabilities = capabilities,
})

-- Use Neovim's LSP client for OCaml and expose its completions to nvim-cmp.
-- Running through opam selects ocamllsp from the active switch.
vim.lsp.config("ocamllsp", {
  cmd = { "opam", "exec", "--", "ocamllsp" },
  capabilities = capabilities,
  -- Preserve Vim's existing OCaml syntax colors instead of applying LSP
  -- semantic-token highlights on top of them.
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

vim.lsp.enable({ "dafny", "ocamllsp" })
