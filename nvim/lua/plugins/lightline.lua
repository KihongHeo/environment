local function status_string(function_name)
  if not function_name then
    return nil
  end

  if vim.fn.exists("*" .. function_name) == 1 then
    return vim.fn.call(function_name, {})
  end

  return nil
end

function _G.LightlineFilename()
  local status_functions = {
    vimfiler = "vimfiler#get_status_string",
    unite = "unite#get_status_string",
    vimshell = "vimshell#get_status_string",
  }
  local status = status_string(status_functions[vim.bo.filetype])

  if status then
    return status
  end

  local filename = vim.fn.expand("%f")
  return filename ~= "" and filename or "[No Name]"
end

vim.g.lightline = {
  colorscheme = "wombat",
  active = {
    left = {
      { "mode", "paste" },
      { "fugitive", "readonly", "filename", "modified" },
    },
    right = {
      { "lineinfo" },
      { "percent" },
    },
  },
  component = {
    filename = "%{v:lua.LightlineFilename()}",
    readonly = '%{&filetype=="help"?"":&readonly?"🔒":""}',
    modified = '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    fugitive = '%{exists("*fugitive#head")?fugitive#head():""}',
  },
  component_visible_condition = {
    readonly = '(&filetype!="help"&& &readonly)',
    modified = '(&filetype!="help"&&(&modified||!&modifiable))',
    fugitive = '(exists("*fugitive#head") && ""!=fugitive#head())',
  },
  separator = { left = " ", right = " " },
  subseparator = { left = " ", right = " " },
}

vim.g.unite_force_overwrite_statusline = 0
vim.g.vimfiler_force_overwrite_statusline = 0
vim.g.vimshell_force_overwrite_statusline = 0

local netrw_lightline_group = vim.api.nvim_create_augroup("config_netrw_lightline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = netrw_lightline_group,
  pattern = "netrw",
  callback = function()
    -- When Neovim starts with a directory, netrw can replace 'statusline'
    -- after lightline's BufEnter handler has already run.
    vim.schedule(function()
      if vim.fn.exists("*lightline#update") == 1 then
        vim.fn["lightline#update"]()
        vim.cmd.redrawstatus()
      end
    end)
  end,
})
