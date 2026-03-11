return {
  {
    "sudo-tee/opencode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons",
        },
        opts = {
          anti_conceal = { enabled = false },
          overrides = {
            filetype = {
              opencode_output = {
                render_modes = true,
                debounce = 0,
                sign = { enabled = false },
                padding = { highlight = "OpencodeBackground" },
              },
            },
          },
        },
      },
      "hrsh7th/nvim-cmp",
      "folke/snacks.nvim",
    },
    config = function()
      local api = _G["vim"].api
      local schedule = _G["vim"].schedule

      local function sanitize_opencode_line(line)
        if type(line) ~= "string" then
          return line
        end

        return (line:gsub("\r", ""))
      end

      -- 공식 옵션이 없는 부분(border 제거, CR 정리)만 최소한으로 패치한다.
      local function patch_opencode_output()
        local ok_output, Output = pcall(require, "opencode.ui.output")
        if ok_output and not Output._opencode_sanitized then
          local original_add_line = Output.add_line
          local original_add_lines = Output.add_lines
          local original_merge_line = Output.merge_line

          Output.add_line = function(self, line)
            return original_add_line(self, sanitize_opencode_line(line))
          end

          Output.add_lines = function(self, lines, prefix)
            local sanitized = {}
            for _, line in ipairs(lines or {}) do
              table.insert(sanitized, sanitize_opencode_line(line))
            end
            return original_add_lines(self, sanitized, prefix)
          end

          Output.merge_line = function(self, idx, text)
            return original_merge_line(self, idx, sanitize_opencode_line(text))
          end

          Output._opencode_sanitized = true
        end

        local ok_window, output_window = pcall(require, "opencode.ui.output_window")
        if ok_window and not output_window._opencode_borderless then
          local original_build = output_window._build_output_win_config
          local original_set_lines = output_window.set_lines

          output_window._build_output_win_config = function(...)
            local win_config = original_build(...)
            win_config.border = "none"
            return win_config
          end

          output_window.set_lines = function(lines, start_line, end_line)
            local sanitized = {}
            for _, line in ipairs(lines or {}) do
              table.insert(sanitized, sanitize_opencode_line(line))
            end
            return original_set_lines(sanitized, start_line, end_line)
          end

          output_window._opencode_borderless = true
        end
      end

      local function apply_opencode_appearance()
        api.nvim_set_hl(0, "OpencodeBackground", { link = "Normal" })
        api.nvim_set_hl(0, "OpencodeBorder", { link = "Normal" })
        api.nvim_set_hl(0, "OpencodeSeparator", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownCode", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownCodeInfo", { link = "Comment" })
        api.nvim_set_hl(0, "RenderMarkdownCodeFallback", { link = "Comment" })
        api.nvim_set_hl(0, "RenderMarkdownH1Bg", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownH2Bg", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownH3Bg", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownH4Bg", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownH5Bg", { link = "Normal" })
        api.nvim_set_hl(0, "RenderMarkdownH6Bg", { link = "Normal" })
      end

      local function refresh_opencode_appearance()
        local ok, highlight = pcall(require, "opencode.ui.highlight")
        if ok then
          highlight.setup()
        end

        apply_opencode_appearance()
      end

      api.nvim_create_autocmd("ColorScheme", {
        callback = refresh_opencode_appearance,
      })

      patch_opencode_output()

      require("opencode").setup({
        preferred_picker = "snacks",
        preferred_completion = "nvim-cmp",

        keymap = {
          editor = {
            ["<leader>a"] = { "toggle" },
            ["<leader>as"] = { "open_input" },
          },
          input_window = {
            ["<esc>"] = false,
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" } },
          },
          output_window = {
            ["<esc>"] = false,
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" } },
          },
        },

        ui = {
          window_highlight = "Normal:OpencodeBackground,NormalNC:OpencodeBackground,EndOfBuffer:OpencodeBackground,SignColumn:OpencodeBackground,FloatBorder:OpencodeBorder,WinSeparator:OpencodeSeparator,VertSplit:OpencodeSeparator",
          output = {
            rendering = {
              markdown_debounce_ms = 75,
              on_data_rendered = function(buf, win)
                local ok, render_markdown = pcall(require, "render-markdown")
                if not ok then
                  return
                end

                if not api.nvim_buf_is_valid(buf) or not api.nvim_win_is_valid(win) then
                  return
                end

                schedule(function()
                  if not api.nvim_buf_is_valid(buf) or not api.nvim_win_is_valid(win) then
                    return
                  end

                  api.nvim_set_option_value("wrap", true, { win = win, scope = "local" })
                  api.nvim_set_option_value("linebreak", true, { win = win, scope = "local" })

                  render_markdown.render({
                    buf = buf,
                    win = win,
                    event = "OpencodeRender",
                    config = {
                      render_modes = true,
                      debounce = 0,
                      sign = { enabled = false },
                      padding = { highlight = "OpencodeBackground" },
                    },
                  })
                end)
              end,
            },
          },
          input = {
            text = {
              wrap = true,
            },
          },
        },
      })

      refresh_opencode_appearance()
    end,
  },
}
