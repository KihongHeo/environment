local opt = vim.opt_local

opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.comments = { "s1:/*", "mb:*", "ex:*/", "://" }
opt.commentstring = "//%s"
opt.suffixesadd:append({ ".dfy" })
opt.include = [[^\s*include]]
opt.includeexpr = "dafny#includeexpr(v:fname)"

vim.bo.define = [[^\s*\(var\|function\|method\|predicate\|lemma\|type\|datatype\|newtype\)]]

vim.b.undo_ftplugin = table.concat({
  "setlocal expandtab< shiftwidth< softtabstop<",
  "setlocal comments< commentstring<",
  "setlocal suffixesadd< include< includeexpr< define<",
}, " | ")
