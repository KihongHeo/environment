vim.g.ale_sign_error = "✘"
vim.g.ale_sign_warning = "⚠"

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = vim.g.ale_sign_error,
      [vim.diagnostic.severity.WARN] = vim.g.ale_sign_warning,
      [vim.diagnostic.severity.INFO] = "ℹ",
      [vim.diagnostic.severity.HINT] = "•",
    },
  },
})

vim.api.nvim_set_hl(0, "ALEErrorSign", {
  ctermfg = "Red",
  ctermbg = "NONE",
})

vim.api.nvim_set_hl(0, "ALEWarningSign", {
  ctermfg = "Yellow",
  ctermbg = "NONE",
})

vim.g.ale_linters = {
  ocaml = { "merlin" },
  python = {},
  tex = { "chktex" },
}

vim.g.ale_fixers = {
  ocaml = { "ocamlformat" },
  ["*"] = { "remove_trailing_lines", "trim_whitespace" },
}
