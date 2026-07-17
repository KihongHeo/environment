local ocamlmerlin = vim.fn.exepath("ocamlmerlin")

if ocamlmerlin ~= "" then
  local opam_prefix = vim.fn.fnamemodify(ocamlmerlin, ":h:h")
  local merlin_runtime = opam_prefix .. "/share/merlin/vim"

  if vim.fn.isdirectory(merlin_runtime) == 1 then
    vim.opt.runtimepath:prepend(merlin_runtime)
  end
end
