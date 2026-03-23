vim.lsp.config('ocamllsp', {
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "ocamlinterface", "ocamllex", "menhir" },
  root_markers = { "dune-project", ".git" },
})

vim.lsp.config('dafny', {
  cmd = { "dafny", "server" },
  filetypes = { "dafny", "dfy" },
  root_markers = { ".git" },
})

vim.lsp.enable('ocamllsp')
vim.lsp.enable('dafny')

-- OCaml lsp가 모듈 이름을 PreProc이 아니라 type으로 매핑하기 때문에, 기본 타입과 색깔이 같아지는 문제가 있음.
-- 그래서 강제로 PreProc으로 매핑하도록 함.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- OCaml namespace semantic token -> PreProc
    vim.api.nvim_set_hl(0, "@lsp.type.namespace.ocaml", { link = "PreProc" })
    vim.api.nvim_set_hl(0, "@lsp.type.interface.ocaml", { link = "PreProc" })
    vim.api.nvim_set_hl(0, "@lsp.type.function.ocaml", { link = "Identifier" })
  end,
})
