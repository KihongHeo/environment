vim.opt.runtimepath:append(vim.fn.expand("~/.vim"))
vim.opt.packpath:append(vim.fn.expand("~/.vim"))

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.lsp")
require("config.opencode")
vim.cmd("source ~/.vimrc")
