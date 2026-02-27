vim.opt.runtimepath:append(vim.fn.expand("~/.vim"))
vim.opt.runtimepath:append(vim.fn.expand("~/.vim/after"))
vim.opt.packpath:append(vim.fn.expand("~/.vim"))

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("config.lazy")
vim.cmd("source ~/.vimrc")
