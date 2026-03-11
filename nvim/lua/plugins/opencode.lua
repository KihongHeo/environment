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
          file_types = { 'markdown' },
          overrides = {
            filetype = {
              opencode_output = {
                render_modes = true,
                debounce = 0,
                sign = { enabled = false },
                padding = { highlight = 'OpencodeBackground' },
              },
            },
          },
        },
      },
      -- Optional, for file mentions and commands completion, pick only one
      -- 'saghen/blink.cmp',
      'hrsh7th/nvim-cmp',

      -- Optional, for file mentions picker, pick only one
      'folke/snacks.nvim',
      -- 'nvim-telescope/telescope.nvim',
      -- 'ibhagwan/fzf-lua',
      -- 'nvim_mini/mini.nvim',
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
        callback = function()
          refresh_opencode_appearance()
        end,
      })

      patch_opencode_output()

      require("opencode").setup({
        preferred_picker = "snacks",
        preferred_completion = "nvim-cmp",
        default_global_keymaps = true,
        default_mode = "build",
        default_system_prompt = nil,
        keymap_prefix = "<leader>o",
        opencode_executable = "opencode",
        server = {
          url = nil,
          port = nil,
          timeout = 5,
          spawn_command = nil,
          auto_kill = true,
          path_map = nil,
        },
        keymap = {
          editor = {
            ["<leader>a"] = { "toggle" },
            ["<leader>ao"] = { "open_input" },
            ["<leader>oI"] = { "open_input_new_session" },
            ["<leader>oo"] = { "open_output" },
            ["<leader>ot"] = { "toggle_focus" },
            ["<leader>oT"] = { "timeline" },
            ["<leader>oq"] = { "close" },
            ["<leader>os"] = { "select_session" },
            ["<leader>oR"] = { "rename_session" },
            ["<leader>op"] = { "configure_provider" },
            ["<leader>oV"] = { "configure_variant" },
            ["<leader>oy"] = { "add_visual_selection", mode = { "v" } },
            ["<leader>oz"] = { "toggle_zoom" },
            ["<leader>ov"] = { "paste_image" },
            ["<leader>od"] = { "diff_open" },
            ["<leader>o]"] = { "diff_next" },
            ["<leader>o["] = { "diff_prev" },
            ["<leader>oc"] = { "diff_close" },
            ["<leader>ora"] = { "diff_revert_all_last_prompt" },
            ["<leader>ort"] = { "diff_revert_this_last_prompt" },
            ["<leader>orA"] = { "diff_revert_all" },
            ["<leader>orT"] = { "diff_revert_this" },
            ["<leader>orr"] = { "diff_restore_snapshot_file" },
            ["<leader>orR"] = { "diff_restore_snapshot_all" },
            ["<leader>ox"] = { "swap_position" },
            ["<leader>ott"] = { "toggle_tool_output" },
            ["<leader>otr"] = { "toggle_reasoning_output" },
            ["<leader>o/"] = { "quick_chat", mode = { "n", "x" } },
          },
          input_window = {
            ["<C-S>"] = { "submit_input_prompt", mode = { "n", "i" } },
            ["<esc>"] = false,
            ["<C-c>"] = { "cancel" },
            ["~"] = { "mention_file", mode = "i" },
            ["@"] = { "mention", mode = "i" },
            ["/"] = { "slash_commands", mode = "i" },
            ["#"] = { "context_items", mode = "i" },
            ["<M-v>"] = { "paste_image", mode = "i" },
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" } },
            ["<up>"] = { "prev_prompt_history", mode = { "n", "i" } },
            ["<down>"] = { "next_prompt_history", mode = { "n", "i" } },
            ["<M-m>"] = { "switch_mode" },
            ["<M-r>"] = { "cycle_variant", mode = { "n", "i" } },
          },
          output_window = {
            ["<esc>"] = false,
            ["<C-c>"] = { "cancel" },
            ["]]"] = { "next_message" },
            ["[["] = { "prev_message" },
            ["<tab>"] = { "toggle_pane", mode = { "n", "i" } },
            ["i"] = { "focus_input", "n" },
            ["<M-r>"] = { "cycle_variant", mode = { "n" } },
            ["<leader>oS"] = { "select_child_session" },
            ["<leader>oD"] = { "debug_message" },
            ["<leader>oO"] = { "debug_output" },
            ["<leader>ods"] = { "debug_session" },
          },
          session_picker = {
            rename_session = { "<C-r>" },
            delete_session = { "<C-d>" },
            new_session = { "<C-s>" },
          },
          timeline_picker = {
            undo = { "<C-u>", mode = { "i", "n" } },
            fork = { "<C-f>", mode = { "i", "n" } },
          },
          history_picker = {
            delete_entry = { "<C-d>", mode = { "i", "n" } },
            clear_all = { "<C-X>", mode = { "i", "n" } },
          },
          model_picker = {
            toggle_favorite = { "<C-f>", mode = { "i", "n" } },
          },
          mcp_picker = {
            toggle_connection = { "<C-t>", mode = { "i", "n" } },
          },
        },
        ui = {
          enable_treesitter_markdown = true,
          position = "right",
          input_position = "bottom",
          window_width = 0.40,
          zoom_width = 0.8,
          display_model = true,
          display_context_size = true,
          display_cost = true,
          window_highlight = "Normal:OpencodeBackground,NormalNC:OpencodeBackground,EndOfBuffer:OpencodeBackground,SignColumn:OpencodeBackground,FloatBorder:OpencodeBorder,WinSeparator:OpencodeSeparator,VertSplit:OpencodeSeparator",
          persist_state = true,
          icons = {
            preset = "nerdfonts",
            overrides = {},
          },
          questions = {
            use_vim_ui_select = false,
          },
          output = {
            tools = {
              show_output = true,
              show_reasoning_output = true,
            },
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
            min_height = 0.10,
            max_height = 0.25,
            text = {
              wrap = true,
            },
            auto_hide = false,
          },
          picker = {
            snacks_layout = nil,
          },
          completion = {
            file_sources = {
              enabled = true,
              preferred_cli_tool = "server",
              ignore_patterns = {
                "^%.git/",
                "^%.svn/",
                "^%.hg/",
                "node_modules/",
                "%.pyc$",
                "%.o$",
                "%.obj$",
                "%.exe$",
                "%.dll$",
                "%.so$",
                "%.dylib$",
                "%.class$",
                "%.jar$",
                "%.war$",
                "%.ear$",
                "target/",
                "build/",
                "dist/",
                "out/",
                "deps/",
                "%.tmp$",
                "%.temp$",
                "%.log$",
                "%.cache$",
              },
              max_files = 10,
              max_display_length = 50,
            },
          },
        },
        context = {
          enabled = true,
          cursor_data = {
            enabled = false,
            context_lines = 5,
          },
          diagnostics = {
            info = false,
            warning = true,
            error = true,
            only_closest = false,
          },
          current_file = {
            enabled = true,
            show_full_path = true,
          },
          files = {
            enabled = true,
            show_full_path = true,
          },
          selection = {
            enabled = true,
          },
          buffer = {
            enabled = false,
          },
          git_diff = {
            enabled = false,
          },
        },
        logging = {
          enabled = false,
          level = "warn",
          outfile = nil,
        },
        debug = {
          enabled = false,
          capture_streamed_events = false,
          show_ids = true,
          quick_chat = {
            keep_session = false,
            set_active_session = false,
          },
        },
        prompt_guard = nil,
        hooks = {
          on_file_edited = nil,
          on_session_loaded = nil,
          on_done_thinking = nil,
          on_permission_requested = nil,
        },
        quick_chat = {
          default_model = nil,
          default_agent = nil,
          instructions = nil,
        },
      })

      refresh_opencode_appearance()
    end,
  }
}
