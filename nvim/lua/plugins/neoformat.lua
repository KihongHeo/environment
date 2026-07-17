vim.g.neoformat_ocaml_ocamlformat = {
  exe = "ocamlformat",
  no_append = 1,
  stdin = 1,
  args = { "--enable-outside-detected-project", "--name", '"%:p"', "-" },
}

vim.g.neoformat_enabled_ocaml = { "ocamlformat" }

vim.g.neoformat_dafny_dafny = {
  exe = "dafny",
  no_append = 1,
  stdin = 1,
  args = { "format", "--stdin", "--print", "--allow-deprecation" },
}

vim.g.neoformat_enabled_dafny = { "dafny" }

vim.g.neoformat_plaintex_latexindent = {
  exe = "latexindent",
  args = { "-l" },
  stdin = 1,
}

vim.g.neoformat_tex_latexindent = {
  exe = "latexindent",
  args = { "-l" },
  stdin = 1,
}

vim.g.neoformat_enabled_python = { "yapf" }
vim.g.neoformat_enabled_cs = { "csharpier" }
vim.g.shfmt_opt = "-ci -i 2"

local format_group = vim.api.nvim_create_augroup("fmt", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.ml", "*.mli", "*.sh", "*.py", "*.json", "dune", "*.c", "*.tex", "*.dfy" },
  callback = function()
    pcall(vim.cmd, "undojoin")
    vim.cmd("silent Neoformat")
  end,
})
