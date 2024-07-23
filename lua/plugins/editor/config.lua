local config = {}

function config.nvimtree()
  return function()
    local Icons = LazyVim.config.icons

    -- local gwidth = vim.api.nvim_list_uis()[1].width
    local gheight = vim.api.nvim_list_uis()[1].height
    local width = 80
    local height = 40

    require("nvim-tree").setup({
      create_in_closed_folder = false,
      respect_buf_cwd = false,
      auto_reload_on_write = true,
      disable_netrw = true,
      hijack_cursor = true,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      open_on_tab = false,
      sort_by = "name",
      sync_root_with_cwd = true,
      view = {
        adaptive_size = false,
        centralize_selection = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
          enable = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = width,
            height = height,
            row = (gheight - height) * 0.45,
            -- col = (gwidth - width) * 0.50,
            col = 13,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = true,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
        symlink_destination = true,
        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
          },
        },
        root_folder_label = ":.:s?.*?/..?",
        icons = {
          webdev_colors = true,
          git_placement = "before",
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
          },
          padding = " ",
          symlink_arrow = "  ",
          glyphs = {
            git = {
              unstaged = "󰄱",
              staged = "󰱒",
            },
            folder = {
              arrow_open = "",
              arrow_closed = "",
            },
          },
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
      filters = {
        dotfiles = false,
        custom = { ".DS_Store" },
        exclude = {},
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
          hint = Icons.diagnostics.Hint,
          info = Icons.diagnostics.Info,
          warning = Icons.diagnostics.Warn,
          error = Icons.diagnostics.Error,
        },
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
      },
      trash = {
        cmd = "gio trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    })
  end
end

function config.telescope()
  local function find_command()
    if 1 == vim.fn.executable("rg") then
      return { "rg", "--files", "--color", "never", "-g", "!.git" }
    elseif 1 == vim.fn.executable("fd") then
      return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
    elseif 1 == vim.fn.executable("fdfind") then
      return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
    elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
      return { "find", ".", "-type", "f" }
    elseif 1 == vim.fn.executable("where") then
      return { "where", "/r", ".", "*" }
    end
  end
  return {
    defaults = {
      initial_mode = "insert",
      entry_prefix = " ",
      scroll_strategy = "limit",
      results_title = false,
      prompt_prefix = " ",
      selection_caret = " ",
      layout_strategy = "horizontal",
      path_display = { "absolute" },
      file_ignore_patterns = {
        ".git/",
        ".cache",
        "%.class",
        "%.pdf",
        "%.mkv",
        "%.mp4",
        "%.zip",
        "node_modules/",
      },
      layout_config = {
        horizontal = {
          preview_width = 0.5,
          preview_cutoff = 0,
        },
      },
      get_selection_window = function()
        local wins = vim.api.nvim_list_wins()
        table.insert(wins, 1, vim.api.nvim_get_current_win())
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].buftype == "" then
            return win
          end
        end
        return 0
      end,
      mappings = {
        i = {
          ["<c-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<a-t>"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
          ["<a-i>"] = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            LazyVim.telescope("find_files", { no_ignore = true, default_text = line })()
          end,
          ["<a-h>"] = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            LazyVim.telescope("find_files", { hidden = true, default_text = line })()
          end,
          ["<C-Down>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-Up>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-f>"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["<C-b>"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
        },
        n = {
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = find_command,
        hidden = true,
      },
      colorscheme = {
        enable_preview = true,
      },
    },
  }
end

function config.whichkey()
  return {
    plugins = {
      spelling = true,
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    win = {
      border = "single",
      padding = { 1, 0, 1, 0 },
      wo = {
        winblend = 0,
      },
    },
    layout = {
      height = { min = 4, max = 8 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    show_help = false,
    show_keys = false,
    spec = {
      mode = { "n", "v" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>s", group = "Search" },
      { "<leader>r", group = "Toggle" },
      { "<leader>\\", group = "Compile" },
      { "<leader>f", hidden = true },
      { "<leader>u", hidden = true },
      { "<leader>b", hidden = true },
      { "<leader>w", hidden = true },
    },
  }
end

function config.gitsigns()
  return {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    watch_gitdir = { interval = 1000, follow_files = true },
    current_line_blame = true,
    current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    word_diff = false,
    diff_opts = { internal = true },
  }
end

function config.illuminate()
  return function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      filetypes_denylist = {
        "alpha",
        "dashboard",
        "DoomInfo",
        "fugitive",
        "help",
        "norg",
        "NvimTree",
        "Outline",
        "packer",
        "toggleterm",
      },
      under_cursor = false,
    })
  end
end

function config.trouble()
  local Icons = LazyVim.config.icons
  return function()
    require("trouble").setup({
      position = "bottom", -- position of the list can be: bottom, top, left, right
      height = 10, -- height of the trouble list when position is top or bottom
      width = 50, -- width of the list when position is left or right
      icons = true, -- use devicons for filenames
      mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      -- fold_open = Icons.ui.ArrowOpen, -- icon used for open folds
      -- fold_closed = Icons.ui.ArrowClosed, -- icon used for closed folds
      group = true, -- group results by file
      padding = true, -- add an extra new line on top of the list
      action_keys = {
        -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j", -- next item
      },
      indent_lines = true, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = false, -- automatically close the list when you have no diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
      signs = {
        -- icons / text used for a diagnostic
        error = Icons.diagnostics.Error,
        warning = Icons.diagnostics.Warn,
        hint = Icons.diagnostics.Hint,
        information = Icons.diagnostics.Info,
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    })
  end
end

function config.neoscroll()
  return function()
    require("neoscroll").setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      hide_cursor = false, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = "quadratic", -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
    })
  end
end

function config.zen()
  return function()
    require("zen-mode").setup({
      window = {
        backdrop = 0.95,
        width = 120,
        height = 0.95,
        options = {
          signcolumn = "yes",
        },
      },
      plugins = {
        gitsigns = { enabled = true },
      },
    })
  end
end

function config.betterEscape()
  return function()
    require("better_escape").setup({
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        t = {
          j = {
            k = false,
            j = false,
          },
        },
      },
    })
  end
end

function config.toggleterm()
  return function()
    require("toggleterm").setup({
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.40
        end
      end,
      on_open = function()
        -- Prevent infinite calls from freezing neovim.
        -- Only set these options specific to this terminal buffer.
        vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
        vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
      end,
      open_mapping = false, -- [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = false,
      shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
    })
  end
end

function config.statuscol()
  return function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      thousands = false,
      relculright = true,
      segments = {
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        { text = { "%s" }, click = "v:lua.ScSa" },
        {
          text = { builtin.foldfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScFa",
        },
      },
    })
  end
end

function config.ufo()
  return function()
    require("ufo").setup({
      open_fold_hl_timeout = 0,
      close_fold_kinds_for_ft = { default = {} },
      enable_get_fold_virt_text = false,
      preview = {},
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end
end

function config.mason()
  return function()
    return {
      ensure_installed = {
        "astro-language-server",
        "clangd",
        "black",
        "debugpy",
        "js-debug-adapter",
        "lua-language-server",
        "prettier",
        "pyright",
        "ruff",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "texlab",
        "vtsls",
      },
      ui = {
        border = "rounded",
      },
    }
  end
end

return config
