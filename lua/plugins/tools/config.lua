local Icons = require("icons")
local config = {}

function config.telescope()
  local icons = { ui = Icons.get("ui", true) }
  local telescope_actions = require("telescope.actions.set")
  local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
      telescope_actions.select:enhance({
        post = function()
          vim.api.nvim_command([[:normal! zx"]])
        end,
      })
      return true
    end,
  }
  local lga_actions = require("telescope-live-grep-args.actions")

  require("telescope").setup({
    defaults = {
      initial_mode = "insert",
      prompt_prefix = " " .. icons.ui.Telescope .. " ",
      selection_caret = icons.ui.ChevronRight,
      entry_prefix = " ",
      scroll_strategy = "limit",
      results_title = false,
      layout_strategy = "horizontal",
      path_display = { "absolute" },
      file_ignore_patterns = { ".git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip", "node_modules/" },
      layout_config = {
        horizontal = {
          preview_width = 0.5,
        },
      },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    },
    extensions = {
      fzf = {
        fuzzy = false,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      frecency = {
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
      undo = {
        side_by_side = true,
        layout_config = {
          preview_height = 0.8,
        },
        mappings = {
          i = {
            ["<cr>"] = require("telescope-undo.actions").yank_additions,
            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-cr>"] = require("telescope-undo.actions").restore,
          },
        },
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
      buffers = fixfolds,
      find_files = fixfolds,
      git_files = fixfolds,
      grep_string = fixfolds,
      live_grep = fixfolds,
      oldfiles = fixfolds,
    },
  })

  require("telescope").load_extension("notify")
  require("telescope").load_extension("projects")
  require("telescope").load_extension("frecency")
  require("telescope").load_extension("live_grep_args")
  require("telescope").load_extension("undo")
end

function config.project()
  require("project_nvim").setup({
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    ignore_lsp = { "efm", "copilot" },
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
  })
end

function config.sniprun()
  require("sniprun").setup({
    selected_interpreters = {}, -- " use those instead of the default for the current filetype
    repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
    repl_disable = {}, -- " disable REPL-like behavior for the given interpreters
    interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>
    display = {
      "Classic", -- "display results in the command-line  area
      "VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)
      "VirtualTextErr", -- "display error results as virtual text
      -- "TempFloatingWindow",      -- "display results in a floating window
      "LongTempFloatingWindow", -- "same as above, but only long results. To use with VirtualText__
      -- "Terminal"                 -- "display results in a vertical split
    },
    -- " miscellaneous compatibility/adjustement settings
    inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
    -- " to workaround sniprun not being able to display anything

    borders = "shadow", -- " display borders around floating windows
    -- " possible values are 'none', 'single', 'double', or 'shadow'
  })
end

function config.trouble()
  local icons = {
    ui = Icons.get("ui"),
    diagnostics = Icons.get("diagnostics"),
  }

  require("trouble").setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = icons.ui.ArrowOpen, -- icon used for open folds
    fold_closed = icons.ui.ArrowClosed, -- icon used for closed folds
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
      error = icons.diagnostics.Error_alt,
      warning = icons.diagnostics.Warning_alt,
      hint = icons.diagnostics.Hint_alt,
      information = icons.diagnostics.Information_alt,
      other = icons.diagnostics.Question_alt,
    },
    use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
  })
end

function config.whichkey()
  local icons = {
    ui = Icons.get("ui"),
    misc = Icons.get("misc"),
  }

  local wk = require("which-key")

  wk.setup({
    plugins = {
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

    icons = {
      breadcrumb = icons.ui.Separator,
      separator = icons.misc.Vbar,
      group = icons.misc.Add,
    },

    window = {
      border = "single",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 1, 0, 1, 0 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 8 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
  })
  wk.register({
    g = { name = "Git" },
    l = { name = "LSP" },
    s = { name = "Search" },
    r = { name = "Toggle" },
    ["\\"] = { name = "Compile" },
  }, { prefix = "<leader>" })
end

function config.dressing()
  require("dressing").setup({
    input = {
      enabled = true,
      relative = "editor",
      prefer_width = 100,
    },
    select = {
      enabled = true,
      backend = { "telescope" },
      trim_prompt = true,
    },
  })
end

function config.markdown()
  vim.fn["mkdp#util#install"]()
end

function config.vimtex()
  local g = vim.g
  g.vimtex_view_method = "zathura"
  g.vimtex_quickfix_enabled = 0
end

return config
