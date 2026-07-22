local restore_cursor_group = vim.api.nvim_create_augroup("config_restore_cursor", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = restore_cursor_group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

local trim_whitespace_group = vim.api.nvim_create_augroup("config_trim_whitespace", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = trim_whitespace_group,
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

local external_changes_group = vim.api.nvim_create_augroup("config_external_changes", { clear = true })

-- Reload files changed outside Neovim as soon as we return to them.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
  group = external_changes_group,
  pattern = "*",
  command = "checktime",
})
