-- Settings read while plugin scripts are loaded.
require("plugins.lightline")
require("plugins.neoformat")
require("plugins.lean")
require("plugins.ale")

-- copilot.vim reads these globals while its plugin script is loading.
-- Let nvim-cmp own Tab while keeping Copilot visible beside its completion menu.
vim.g.copilot_no_tab_map = true
vim.g.copilot_hide_during_completion = false

vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/KihongHeo/vim-dafny" },
  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/Julian/lean.nvim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/itchyny/lightline.vim" },
  { src = "https://github.com/sbdchd/neoformat" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/dense-analysis/ale" },
  { src = "https://github.com/scrooloose/nerdcommenter" },
})

-- Settings that import modules provided by the plugins above.
require("plugins.autopairs")
require("plugins.nvim-cmp")
-- Load Copilot keymaps after nvim-cmp so their key ownership is explicit.
require("plugins.copilot")
