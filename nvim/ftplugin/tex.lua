local opt = vim.opt_local

opt.colorcolumn = "120"
opt.tabstop = 2

vim.b.undo_ftplugin = table.concat({
  "setlocal colorcolumn< tabstop<",
}, " | ")
