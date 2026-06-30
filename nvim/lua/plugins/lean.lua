return {
  { "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      vim.g.lean_config = {
        mappings = true,
        lsp = {
          semanticHighlighting = false,
        },
      }
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lean",
        callback = function()
          vim.opt_local.colorcolumn = "80"
        end,
      })
    end,
  },
}
