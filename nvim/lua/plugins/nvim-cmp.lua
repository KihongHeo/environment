local cmp = require("cmp")

cmp.setup({
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
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
