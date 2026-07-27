local autopairs = require("nvim-autopairs")

autopairs.setup({
  map_bs = false,
})

local function keycodes(keys)
  return vim.api.nvim_replace_termcodes(keys, true, true, true)
end

vim.keymap.set("i", "<BS>", function()
  local cursor = vim.api.nvim_win_get_cursor(0)

  if cursor[2] == 0 and cursor[1] > 1 then
    -- Join at the byte-independent line boundary. This avoids pair-matching
    -- logic interpreting multibyte text before Neovim handles the backspace.
    return keycodes("<C-g>U<C-o>k<C-o>gJ")
  end

  return autopairs.autopairs_bs()
end, {
  expr = true,
  replace_keycodes = false,
  desc = "Delete pair or join with previous line",
})
