local cmp = require("cmp")
local map = vim.keymap.set

map({ "n", "x" }, "<leader>ca", "<Plug>(coc-codeaction-selected)", {
  remap = true,
  silent = true,
  desc = "Coc: code action for selection",
})
map("n", "<leader>ac", "<Plug>(coc-codeaction)", {
  remap = true,
  silent = true,
  desc = "Coc: code action",
})
map("n", "<leader>qf", "<Plug>(coc-fix-current)", {
  remap = true,
  silent = true,
  desc = "Coc: fix current diagnostic",
})
map("n", "<leader>cl", "<Plug>(coc-codelens-action)", {
  remap = true,
  silent = true,
  desc = "Coc: code lens action",
})

local function coc_pum_visible()
  return vim.fn["coc#pum#visible"]() == 1
end

local function completion_key(coc_action, coc_insert, cmp_action, fallback)
  return function()
    if coc_pum_visible() then
      return vim.fn[coc_action](coc_insert)
    end

    if cmp.visible() then
      cmp_action()
      return ""
    end

    return fallback
  end
end

local expression_options = {
  expr = true,
  silent = true,
}

local function setup_completion_mappings()
  map("i", "<Tab>", completion_key("coc#pum#next", 1, cmp.select_next_item, "<Tab>"), expression_options)
  map("i", "<S-Tab>", completion_key("coc#pum#prev", 1, cmp.select_prev_item, "<S-Tab>"), expression_options)
  map("i", "<Up>", completion_key("coc#pum#prev", 0, cmp.select_prev_item, "<Up>"), expression_options)
  map("i", "<Down>", completion_key("coc#pum#next", 0, cmp.select_next_item, "<Down>"), expression_options)
end

if vim.v.vim_did_enter == 1 then
  setup_completion_mappings()
else
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = setup_completion_mappings,
  })
end
