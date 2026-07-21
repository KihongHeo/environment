vim.g.lean_config = {
  mappings = true,
  -- Kitty graphics can corrupt split separators when Neovim runs through
  -- tmux/SSH. Infoview keeps its text fallbacks with graphics disabled.
  graphics = {
    enabled = false,
  },
  infoview = {
    update_cooldown = 250,
  },
}

local infoview_mouse_group = vim.api.nvim_create_augroup("config_lean_infoview_mouse", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = infoview_mouse_group,
  pattern = "leaninfo",
  callback = function(event)
    vim.keymap.set("n", "<LeftMouse>", function()
      local mouse = vim.fn.getmousepos()
      if mouse.winid == 0 or not vim.api.nvim_win_is_valid(mouse.winid) then
        return
      end

      if vim.api.nvim_win_get_buf(mouse.winid) == event.buf then
        local click = vim.fn.maparg("<Plug>(LeanInfoviewMouseClick)", "n", false, true)
        if type(click.callback) == "function" then
          click.callback()
        end
        return
      end

      -- lean.nvim's buffer-local mouse mapping otherwise swallows clicks in
      -- other windows. Reproduce the normal window/cursor movement explicitly.
      vim.api.nvim_set_current_win(mouse.winid)
      if mouse.line > 0 and mouse.column > 0 then
        local line = math.min(mouse.line, vim.api.nvim_buf_line_count(0))
        local text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ""
        vim.api.nvim_win_set_cursor(mouse.winid, { line, math.min(mouse.column - 1, #text) })
      end
    end, {
      buffer = event.buf,
      silent = true,
      desc = "Lean infoview click without swallowing other windows",
    })
  end,
})
