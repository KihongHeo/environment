local function apply_highlights()
  local highlights = {
    Normal = { bg = "NONE", ctermbg = "NONE" },
    Comment = { fg = "#87d7ff", ctermfg = "Cyan", italic = true },
    Statement = { fg = "#f3eb7a", ctermfg = 220 },
    Keyword = { fg = "#f3eb7a", ctermfg = 220 },
    LineNr = { fg = "#f3eb7a", ctermfg = 220 },
    PreProc = { fg = "#729fcf", ctermfg = "LightBlue", bold = true },
    DiffAdd = { bg = "#3464a4", ctermbg = "Blue" },
    DiffText = { bg = "#e15140", ctermbg = "Red", bold = true },
    DiffChange = { bg = "#7f698b", ctermbg = "DarkMagenta" },
    Pmenu = { fg = "White", bg = "#5a3535", ctermfg = "White", ctermbg = 237 },
    Type = { fg = "#43ff9d" },
    NonText = { fg = "#3464a4", ctermfg = "Blue" },
    Title = { fg = "#ffcfff", ctermfg = "LightMagenta" },
    Identifier = { fg = "White", ctermfg = "White" },
    Function = { fg = "#87d7ff", ctermfg = "Cyan", bold = true },
    Search = { bg = "#f3eb7a", ctermbg = "Yellow", fg = "#000000", ctermfg = "Black" },
    Todo = { fg = "#3464a4", bg = "#f3eb7a", ctermfg = "Black", ctermbg = "Yellow" },
    Error = { fg = "White", bg = "#e15140", ctermfg = "White", ctermbg = "Red", bold = true },
    ErrorMsg = { fg = "White", bg = "#b0451c", ctermfg = "White", ctermbg = "DarkRed" },
    Question = { fg = "#43ff9d", ctermfg = "LightGreen" },
    DiagnosticError = { fg = "#b0451c", ctermfg = "DarkRed" },
    Added = { fg = "#8edf3a", ctermfg = "Green" },
    Removed = { fg = "#e15140", ctermfg = "Red" },
    Visual = { bg = "#3a3a3a" },
    CursorLine = { bg = "#2a2a2a" },
    CursorLineNr = { fg = "#ffd75f", bold = true },
    SignColumn = { bg = "#202020" },
    StatusLine = { link = "Normal" },
    StatusLineNC = { link = "Normal" },

    -- Lean infoview diff colors are independent of the editor's diff colors.
    LeanInfoDiffDelete = { bg = "#ab5e5f" },
    LeanInfoDiffChange = { bg = "#ab5e5f" },
    leanInfoHypNameRemoved = { link = "LeanInfoDiffDelete" },
    leanInfoGoalRemoved = { link = "LeanInfoDiffDelete" },
    leanInfoDiffwillChange = { link = "LeanInfoDiffDelete" },
    leanInfoDiffwasDeleted = { link = "LeanInfoDiffDelete" },
    leanInfoDiffwillDelete = { link = "LeanInfoDiffDelete" },
    widgetElementHighlight = { link = "LeanInfoDiffChange" },
  }

  for group, attributes in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, attributes)
  end
end

vim.cmd.colorscheme("vim")
apply_highlights()

local highlight_group = vim.api.nvim_create_augroup("config_highlights", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = highlight_group,
  callback = apply_highlights,
})
