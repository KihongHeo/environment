vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  silent = true,
  replace_keycodes = false,
  desc = "Copilot: accept suggestion",
})

vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", {
  remap = true,
  silent = true,
  desc = "Copilot: previous suggestion",
})

vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", {
  remap = true,
  silent = true,
  desc = "Copilot: next suggestion",
})
