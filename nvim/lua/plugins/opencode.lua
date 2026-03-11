return {
  {
    "sudo-tee/opencode.nvim",
    config = function()
      require("opencode").setup({})
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons",
        },
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown" },
          overrides = {
            filetype = {
              opencode_output = {
                render_modes = true,
                debounce = 0,
                sign = { enabled = false },
                padding = { highlight = "OpencodeBackground" },
              },
            },
          },
        },
      },
      -- Optional, for file mentions and commands completion, pick only one
      'saghen/blink.cmp',
      -- 'hrsh7th/nvim-cmp',

      -- Optional, for file mentions picker, pick only one
      'folke/snacks.nvim',
      -- 'nvim-telescope/telescope.nvim',
      -- 'ibhagwan/fzf-lua',
      -- 'nvim_mini/mini.nvim',
    },
  }
}
