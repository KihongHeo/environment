vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'llvm' },
  callback = function() vim.treesitter.start() end,
})
