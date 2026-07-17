vim.keymap.set("n", "K", function()
  if vim.fn.exists("*CocActionAsync") == 1 then
    vim.fn.CocActionAsync("doHover")
  else
    vim.notify("Coc is not available", vim.log.levels.WARN)
  end
end, {
  buffer = true,
  silent = true,
  desc = "Show ocamllsp hover",
})

vim.keymap.set("n", "<leader>t", "<cmd>MerlinTypeOf<CR>", {
  buffer = true,
  silent = true,
  desc = "Show Merlin type",
})

vim.keymap.set("x", "<leader>t", "<cmd>MerlinTypeOfSel<CR>", {
  buffer = true,
  silent = true,
  desc = "Show Merlin type for selection",
})

vim.b.undo_ftplugin = table.concat({
  vim.b.undo_ftplugin or "",
  "silent! nunmap <buffer> K",
  "silent! nunmap <buffer> <leader>t",
  "silent! xunmap <buffer> <leader>t",
}, " | ")
