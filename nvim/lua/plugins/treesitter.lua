local treesitter = require("nvim-treesitter")

treesitter.setup()
treesitter.install({ "llvm" }):wait(300000)
