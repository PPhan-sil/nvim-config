local config = {}

function config.nord()
  vim.g.nord_contrast = true
  vim.g.nord_borders = false
  vim.g.nord_cursorline_transparent = false
  vim.g.nord_disable_background = false
  vim.g.nord_enable_sidebar_background = true
  vim.g.nord_italic = true
end

function config.edge()
  vim.g.edge_style = "neon"
  vim.g.edge_enable_italic = 1
  vim.g.edge_disable_italic_comment = 1
  vim.g.edge_show_eob = 1
  vim.g.edge_better_performance = 1
  vim.g.edge_transparent_background = 1
end

function config.nvim_notify()
  return {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  }
end

function config.bufferline()
  return {
    options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = "nvim_lsp",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      always_show_bufferline = true,
      separator_style = "slant",
      show_buffer_close_icons = true,
      show_buffer_icons = true,
      show_tab_indicators = true,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "center",
        },
      },
    },
  }
end

function config.statusline()
  return function()
    local icons = require("lazyvim.config").icons
    local Util = require("lazyvim.util")
    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end
    local function python_venv()
      local function env_cleanup(venv)
        if string.find(venv, "/") then
          local final_venv = venv
          for w in venv:gmatch("([^/]+)") do
            final_venv = w
          end
          venv = final_venv
        end
        return venv
      end

      if vim.bo.filetype == "python" then
        local venv = os.getenv("CONDA_DEFAULT_ENV")
        if venv then
          return string.format("%s", env_cleanup(venv))
        end
        venv = os.getenv("VIRTUAL_ENV")
        if venv then
          return string.format("%s", env_cleanup(venv))
        end
      end
      return ""
    end

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch" },
          {
            "diff",
            source = diff_source,
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
        },
        lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.fg("Debug"),
            },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
        },
        lualine_y = {
          { "filetype", colored = true, icon_only = true },
          { python_venv },
          { "encoding" },
          {
            "fileformat",
            icons_enabled = true,
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
        },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end
end

function config.indent_blankline()
  return {
    -- char = "▏",
    char = "│",
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  }
end

function config.indentscope()
  return {
    -- symbol = "▏",
    symbol = "│",
    options = { try_as_border = true },
  }
end

function config.noice()
  return {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          find = "%d+L, %d+B",
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
  }
end

function config.alpha()
  return function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⣶⣤⣶⣿⣿⣷⣶⣦⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⢀⣴⡿⢿⣿⣿⠿⠻⠿⢿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠟⠋⣴⣦⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠟⠛⠛⢿⡟⠛⠿⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣧⠀⠀⠀⠀⠀⣠⡖⠀⠀⢀⣸⡿⠁⠀⠘⠿⣿⣶⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠲⢔⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⡀⠀⠀⠀⢸⡇⠀⢀⣴⣿⣿⠃⠀⠀⠀⠀⢀⣼⣿⣿⣿⣉⠻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠪⣛⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⡇⠀⠀⠀⠊⠀⣶⣿⣿⣿⣿⠀⠀⠀⠀⣴⣿⣿⣿⡿⠿⠿⢿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡝⢷⣄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣴⣿⠟⠉⠉⢿⠀⠀⠀⣀⣼⣿⣿⣿⣿⣿⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣶⣦⣀⡙⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢦⠙⣷⣄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣼⠟⠁⠀⠀⠀⠈⣧⢀⣾⣿⣿⣿⣿⣿⣿⣿⡀⢀⣾⣿⣿⣿⣿⠖⠀⠀⠉⠉⠛⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡈⢿⣦⠀⠀⠀
⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⠈⢿⣧⠀⠀
⠀⠀⣰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣮⣻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠘⣿⣇⠀
⠀⠀⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⢯⣛⣛⣥⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⢹⣿⡄
⠀⢰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣹⣿⣿⣿⣿⣿⡟⠁⠀⠀⠉⠂⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠸⣿⡇
⠀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣾⣿⠿⠿⠿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⣿⣿
⢸⡇⠀⠀⠀⢠⠞⠓⢄⠀⠀⢀⣴⣿⡟⢱⢆⠀⠀⢀⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠀⠀⣿⣿
⣸⡇⠀⢀⡴⠁⠀⠀⢀⣷⣿⣿⣿⣿⡀⠃⠈⠀⢀⢚⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⣿⣿
⣿⡇⢠⠎⠀⠀⠀⠀⠸⠏⠘⡿⠋⠟⠃⠀⠀⠐⠃⢸⣿⣿⣿⣿⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠀⠀⢸⣿⡏
⣿⡇⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢠⠁⠀⠀⠀⠀⠈⡿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠁⠀⢀⣿⣿⠃
⢹⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⠀⠀⠀⠀⠀⠀⢇⢻⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠁⠀⢀⣾⣿⠏⠀
⠈⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠃⠀⠀⠀⠀⠀⠘⡌⢿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⢠⣿⣿⣿⣿⡃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠾⠋⠀⠀⣠⣿⣿⡟⠀⠀
⠀⠈⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⡙⢿⣿⣿⣿⣿⣿⣿⣷⣤⣄⡀⠉⠙⠻⠿⣷⣤⣀⣀⣀⣤⣤⠶⠞⠋⠁⠀⠀⢀⣴⣿⣿⠏⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣶⣍⡛⠿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⣿⡿⠃⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣷⣮⣝⠻⢿⣿⣿⡿⢿⡿⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣷⣦⣽⣿⣷⣤⣤⣦⣤⣤⣤⣤⣤⣤⣶⣾⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠿⠿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      -- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      -- dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
      dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end
end

function config.navic()
  return function()
    return {
      separator = " ",
      highlight = true,
      depth_limit = 5,
      icons = require("lazyvim.config").icons.kinds,
    }
  end
end

function config.neodim()
  return function()
    local normal_background = vim.api.nvim_get_hl_by_name("Normal", true).background
    local blend_color = normal_background ~= nil and string.format("#%06x", normal_background) or "#000000"
    require("neodim").setup({
      alpha = 0.45,
      blend_color = blend_color,
      update_in_insert = {
        enable = true,
        delay = 100,
      },
      hide = {
        virtual_text = true,
        signs = false,
        underline = false,
      },
    })
  end
end

return config
