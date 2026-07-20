local function hover_lines(contents)
  local lines

  if type(contents) == "string" then
    lines = vim.split(contents, "\n", { trimempty = true })
  elseif contents.kind or contents.language then
    lines = vim.split(contents.value or "", "\n", { trimempty = true })
  else
    lines = vim.lsp.util.convert_input_to_markdown_lines(contents)
  end

  -- ocamllsp may wrap the type in a Markdown code fence. Strip only the fence
  -- markers, then let Vim's OCaml syntax color the complete hover contents.
  return vim.tbl_filter(function(line)
    return not line:match("^%s*```[%w_-]*%s*$")
  end, lines)
end

local function ocaml_hover()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local client

  for _, candidate in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if candidate.name == "ocamllsp" and candidate:supports_method("textDocument/hover") then
      client = candidate
      break
    end
  end

  if not client then
    vim.notify("ocamllsp hover is not available", vim.log.levels.INFO)
    return
  end

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:request("textDocument/hover", params, function(err, result)
    if err then
      vim.notify(err.message or "ocamllsp hover failed", vim.log.levels.ERROR)
      return
    end

    if not result or not result.contents then
      vim.notify("No hover information available", vim.log.levels.INFO)
      return
    end

    if vim.api.nvim_get_current_buf() ~= bufnr or not vim.deep_equal(vim.api.nvim_win_get_cursor(0), cursor) then
      return
    end

    local lines = hover_lines(result.contents)
    if vim.tbl_isempty(lines) then
      vim.notify("No hover information available", vim.log.levels.INFO)
      return
    end

    vim.lsp.util.open_floating_preview(lines, "ocaml", {
      focus_id = "textDocument/hover",
    })
  end, bufnr)
end

-- Render every ocamllsp hover shape with the same Vim OCaml syntax groups used
-- by the source buffer, including Markdown-wrapped type signatures.
vim.keymap.set("n", "K", ocaml_hover, {
  buffer = true,
  silent = true,
  desc = "Show syntax-highlighted ocamllsp hover",
})

vim.keymap.set("n", "<leader>t", "<cmd>MerlinTypeOf<CR>", {
  buffer = true,
  silent = true,
  desc = "Show Merlin type",
})

vim.keymap.set("x", "<leader>t", "<cmd>MerlinTypeOfSel<CR>", {
  buffer = true,
  silent = true,
  desc = "Show Merlin type for selection",
})

vim.b.undo_ftplugin = table.concat({
  vim.b.undo_ftplugin or "",
  "silent! nunmap <buffer> K",
  "silent! nunmap <buffer> <leader>t",
  "silent! xunmap <buffer> <leader>t",
}, " | ")
