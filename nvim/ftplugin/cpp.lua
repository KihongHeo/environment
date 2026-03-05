local opt = vim.opt_local

opt.colorcolumn = "80"
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

vim.g.cpp_no_function_highlight = 1

vim.b.undo_ftplugin = table.concat({
  "setlocal colorcolumn< tabstop< softtabstop< shiftwidth<",
}, " | ")
