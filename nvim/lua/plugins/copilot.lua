local map = vim.keymap.set

map("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  silent = true,
  replace_keycodes = false,
  desc = "Copilot: accept suggestion",
})

local function cycle(method)
  return function()
    vim.fn[method]()
  end
end

-- These callbacks bypass completion-menu mappings owned by nvim-cmp.
map("i", "<C-n>", cycle("copilot#Next"), {
  silent = true,
  desc = "Copilot: next suggestion",
})

map("i", "<C-p>", cycle("copilot#Previous"), {
  silent = true,
  desc = "Copilot: previous suggestion",
})
