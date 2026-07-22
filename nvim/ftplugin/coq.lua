-- Keep Coqtail's syntax and file detection without loading its proof client.
-- Setting this here also prevents Coqtail's ftplugin from registering its
-- commands and mappings alongside coq-lsp.nvim.
vim.b.did_ftplugin = 1

local opt = vim.opt_local

opt.suffixesadd:append({ ".v" })
opt.commentstring = "(*%s*)"
opt.comments = { "srn:(*", "mb:*", "ex:*)" }
opt.formatoptions:remove("tro")
opt.formatoptions:append("cql")

vim.b.undo_ftplugin = table.concat({
  "setlocal suffixesadd< commentstring< comments< formatoptions<",
}, " | ")
