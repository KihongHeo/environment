vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  silent = true,
  desc = "Clear search highlight",
})

vim.keymap.set("n", "<leader>s", function()
  vim.wo.spell = not vim.wo.spell
  vim.notify("Spell checking " .. (vim.wo.spell and "enabled" or "disabled"))
end, {
  silent = true,
  desc = "Toggle spell checking",
})
