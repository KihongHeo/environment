local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("coq-lsp").setup({
  lsp = {
    -- Select coq-lsp from the active opam switch even when its bin directory
    -- is not present in Neovim's inherited PATH.
    cmd = { "opam", "exec", "--", "coq-lsp" },
    capabilities = capabilities,
  },
})
