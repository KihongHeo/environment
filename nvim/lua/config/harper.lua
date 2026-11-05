-- Show Harper diagnostics in the command area, like ALE's cursor messages.
local function configure_client(client)
  for _, is_pull in ipairs({ false, true }) do
    local namespace = vim.lsp.diagnostic.get_namespace(client.id, is_pull)
    vim.diagnostic.config({ virtual_text = true }, namespace)
  end
end

vim.lsp.config("harper_ls", {
  on_attach = configure_client,
})

-- Also apply this when sourcing the file in an existing Neovim session.
for _, client in ipairs(vim.lsp.get_clients({ name = "harper_ls" })) do
  configure_client(client)
end

local group = vim.api.nvim_create_augroup("config_harper_messages", { clear = true })
local showing_message = false

local function clear_message()
  if showing_message then
    vim.api.nvim_echo({ { "" } }, false, {})
    showing_message = false
  end
end

local pending = 0
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold", "BufEnter", "DiagnosticChanged" }, {
  group = group,
  callback = function(event)
    if event.buf ~= vim.api.nvim_get_current_buf() then
      return
    end
    pending = pending + 1
    local request = pending
    -- Echo after cursor redraw; CursorHold alone waits for 'updatetime'
    -- (normally four seconds) and does not run again without new input.
    vim.defer_fn(function()
      if request ~= pending or vim.api.nvim_get_mode().mode ~= "n" then
        return
      end
      local diagnostics = {}
      local line = vim.api.nvim_win_get_cursor(0)[1] - 1
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0, name = "harper_ls" })) do
        for _, is_pull in ipairs({ false, true }) do
          local namespace = vim.lsp.diagnostic.get_namespace(client.id, is_pull)
          vim.list_extend(diagnostics, vim.diagnostic.get(0, { namespace = namespace, lnum = line }))
        end
      end

      table.sort(diagnostics, function(a, b)
        if a.severity ~= b.severity then
          return a.severity < b.severity
        end
        return a.col < b.col
      end)

      local diagnostic = diagnostics[1]
      if diagnostic then
        local severity = vim.diagnostic.severity[diagnostic.severity]
        local highlight = "Diagnostic" .. severity:sub(1, 1) .. severity:sub(2):lower()
        local message = "[Harper] " .. diagnostic.message:gsub("%s+", " ")
        -- Fit one command line so long explanations never trigger a hit-enter prompt.
        local width = math.max(1, vim.v.echospace)
        while vim.fn.strdisplaywidth(message) > width do
          message = vim.fn.strcharpart(message, 0, vim.fn.strchars(message) - 1)
        end
        vim.api.nvim_echo({ { message, highlight } }, false, {})
        showing_message = true
      else
        clear_message()
      end
    end, 30)
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "BufLeave" }, {
  group = group,
  callback = function()
    pending = pending + 1
    clear_message()
  end,
})

vim.lsp.enable("harper_ls")
