pcall(vim.treesitter.start, 0, "markdown")

vim.opt_local.colorcolumn = "120"

vim.b.undo_ftplugin = "setlocal colorcolumn<"
