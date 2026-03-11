vim.opt.runtimepath:append(vim.fn.expand("~/.vim"))
vim.opt.packpath:append(vim.fn.expand("~/.vim"))

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Clean look: remove ~ from empty lines, use thin vertical bars
vim.opt.fillchars = {
  eob = " ",           -- Replace ~ with a space
  vert = "│",          -- Use a thin vertical line
  fold = " ",          -- Customize fold character
  diff = "╱",          -- Character for diff filler lines
  msgsep = "‾",        -- Separator for messages
}

require("config.lazy")
require("config.lsp")
require("config.opencode")
vim.cmd("source ~/.vimrc")
