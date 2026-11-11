local cmp = require("cmp")

cmp.setup({
  -- Select a candidate explicitly with Tab before Enter can confirm it.
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  window = {
    completion = {
      side_padding = 0,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    -- Reserve Ctrl-n/Ctrl-p for Copilot; cmp navigation uses Tab instead.
    ["<C-n>"] = cmp.config.disable,
    ["<C-p>"] = cmp.config.disable,
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- VimTeX supplies LaTeX completions; retain the shared Tab/Enter mappings.
cmp.setup.filetype({ "tex", "plaintex" }, {
  sources = cmp.config.sources({
    { name = "vimtex" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})
