return {
  {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    opts = {
      interactions = {
        chat = {
          adapter = {
            name = "opencode",
            model = "openai/gpt-5.4",
          },
        },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
