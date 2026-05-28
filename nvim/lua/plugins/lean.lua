return {
  { "Julian/lean.nvim",
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = { mappings = true },
    config = function()
      require("lean").setup({
        lsp = {
          semanticHighlighting = false,
        }
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lean",
        callback = function()
          vim.opt_local.colorcolumn = "80"
        end,
    })
  end,
  },
}
