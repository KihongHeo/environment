vim.opt_local.colorcolumn = "80"

vim.keymap.set("n", "K", function()
  if vim.fn.exists("*CocActionAsync") == 1 then
    vim.fn.CocActionAsync("doHover")
  else
    vim.cmd.normal({ "K", bang = true })
  end
end, { buffer = true, silent = true })

vim.b.undo_ftplugin = "setlocal colorcolumn< | silent! nunmap <buffer> K"
