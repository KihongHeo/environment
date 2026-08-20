local vim = _G["vim"]

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("config.options")
require("config.filetypes")
require("config.keymaps")
require("config.autocmds")
require("config.highlights")
require("config.merlin")
require("plugins")
require("config.lsp")
