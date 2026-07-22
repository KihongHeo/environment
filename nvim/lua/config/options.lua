local opt = vim.opt

-- User interface
opt.number = true
opt.cursorline = true
opt.wrap = false
opt.showcmd = true
opt.signcolumn = "auto"
opt.mouse = "nc"
opt.clipboard = "unnamedplus"
opt.scrolloff = 3
opt.fillchars = {
  eob = " ",
  vert = "│",
  fold = " ",
  diff = "╱",
  msgsep = "‾",
}

-- Files, backups, and undo
opt.autoread = true
opt.autowrite = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Search and windows
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.splitbelow = true
opt.winheight = 5

-- Colors
opt.termguicolors = true
