local conf = require("plugins.editor.config")

return {
  -- file explorer
  {
    "kyazdani42/nvim-tree.lua",
    event = "VeryLazy",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
    },
    config = conf.nvimtree(),
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", false}, -- Replace in files (Spectre)
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- { "<leader>/", false },
      { "<leader>sb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>sf", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>sF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>sg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>st", LazyVim.pick("live_grep", { root = false }), desc = "Grep" },
      { "<leader>sc", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme" },
      { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },

      { "<leader>,", false }, -- Switch Buffer
      { "<leader>/", false }, -- Grep (Root Dir)
      { "<leader>:", false }, -- Command History
      { "<leader>s:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", false }, -- Find Files (Root Dir)
      -- find
      { "<leader>fb", false }, --Buffers
      { "<leader>fc", false }, -- Find Config File
      { "<leader>ff", false }, -- Find Files (Root Dir)
      { "<leader>fF", false }, -- Find Files (cwd)
      { "<leader>fg", false }, --Find Files (git-files)
      { "<leader>fr", false }, -- Recent
      { "<leader>fR", false }, -- Recent (cwd)
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- search
      { '<leader>s"', false }, -- Registers
      { "<leader>sa", false }, -- Auto Commands
      -- { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      -- { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sc", false }, -- Commands
      { "<leader>sC", false }, -- Commands
      -- { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      -- { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      -- { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", false }, -- Grep (cwd)
      { "<leader>sH", false }, -- Search Highlight Groups
      { "<leader>sj", false }, -- Jumplist
      { "<leader>sh", false }, -- Help Pages
      { "<leader>sk", false }, -- Key Maps
      { "<leader>sl", false }, -- Location List
      { "<leader>sM", false }, -- Man Pages
      { "<leader>sm", false }, -- Jump to Mark
      { "<leader>so", false }, -- Options
      { "<leader>sR", false }, -- Resume
      { "<leader>sq", false }, -- Quickfix List
      { "<leader>sw", false }, -- Word (Root Dir)
      { "<leader>sW", false }, -- Word (cwd)
      { "<leader>sw", false }, -- Selection (Root Dir)
      { "<leader>sW", false }, -- Selection (cwd)
      { "<leader>uC", false }, -- Colorscheme with Preview
      { "<leader>ss", false }, -- Goto Symbol
      { "<leader>sS", false }, -- Goto Symbol (Workspace)
    },
    opts = conf.telescope(),
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>sc", LazyVim.pick("colorschemes", { enable_preview = true }), desc = "Colorscheme" },
      { "<leader>ss", false }, -- Goto Symbol
      { "<leader>sS", false }, -- Goto Symbol (Workspace)
      { "<leader>ss", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = conf.whichkey(),
    keys = {
      -- TODO: Fix these conflicting binds
      { "<leader>?", false }, -- Buffer Keymaps (which-key)
      { "<leader>w<space>", false }, -- Buffer Keymaps (which-key)
      { "<leader>wd", false }, -- Buffer Keymaps (which-key)
      { "<leader>wD", false }, -- Buffer Keymaps (which-key)
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.add(opts.defaults)
      end
    end,
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = conf.gitsigns(),
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = conf.illuminate(),
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = conf.trouble(),
    keys = {
      { "<leader>xx", false }, -- Diagnostics (Trouble)
      { "<leader>xX", false }, -- Buffer Diagnostics (Trouble)
      { "<leader>cs", false }, -- Symbols (Trouble)
      { "<leader>cS", false }, -- LSP references/definitions/... (Trouble)
      { "<leader>xL", false }, -- Location List (Trouble)
      { "<leader>xQ", false }, -- Quickfix List (Trouble)
      { "[q", false }, -- Previous Trouble/Quickfix Item
      { "]q", false }, -- Next Trouble/Quickfix Item
    },
  },

  -- Smooth scroll
  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "BufReadPost",
  --   opts = conf.neoscroll(),
  -- },

  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    event = "UIEnter",
    opts = conf.zen(),
  },

  -- Use jj for esc
  {
    "max397574/better-escape.nvim",
    event = "BufReadPost",
    opts = conf.betterEscape(),
  },

  -- Toggle Term
  {
    "akinsho/toggleterm.nvim",
    event = "UIEnter",
    config = conf.toggleterm(),
  },

  -- Better Folds
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
      { "luukvbaal/statuscol.nvim", config = conf.statuscol() },
    },
    config = conf.ufo(),
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    keys = {
      { "<leader>cm", false }, -- Mason
    },
    opts = conf.mason(),
  },

  -- Conform
  -- {
  --   "stevearc/conform.nvim",
  --   keys = {
  --     { "<leader>cF", false }, -- Format Injected Langs
  --   },
  --   opts = {
  --     default_format_opts = {
  --       timeout_ms = 3000,
  --       async = false, -- not recommended to change
  --       quiet = false, -- not recommended to change
  --       lsp_format = "fallback", -- not recommended to change
  --     },
  --     formatters_by_ft = {
  --       lua = { "stylua" },
  --       ["python"] = { "black" },
  --       sh = { "shfmt" },
  --     },
  --     formatters = {
  --       injected = { options = { ignore_errors = true } },
  --       black = {
  --         prepend_args = { "--line-length", "120" },
  --       },
  --     },
  --   },
  -- },

  -- auto pairs
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
    config = function(_, opts)
      LazyVim.mini.pairs(opts)
    end,
  },
  {
    "nvim-mini/mini.surround",
    recommended = true,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = LazyVim.opts("mini.surround")
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    recommended = true,
    desc = "Better Yank/Paste",
    event = "LazyFile",
    opts = {
      highlight = { timer = 50 },
      ring = {
        history_length = 50,
        storage = "shada",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
        update_register_on_cycle = false,
        permanent_wrapper = nil,
      },
    },
    keys = {
      {
        "<leader>p",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
        -- stylua: ignore
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
      -- { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
      -- { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
      -- { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      -- { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      -- { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      -- { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      -- { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
      -- { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
      -- { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
      -- { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
      -- { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
      -- { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>/", "gcc", desc = "Comment line" },
    },
  },
  -- {
  --   "nvim-mini/mini.snippets",
  --   -- event = "InsertEnter", -- don't depend on other plugins to load...
  --   dependencies = "rafamadriz/friendly-snippets",
  --   opts = function()
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     LazyVim.cmp.actions.snippet_stop = function() end -- by design, <esc> should not stop the session!
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     LazyVim.cmp.actions.snippet_forward = function()
  --       return jump("next")
  --     end
  --
  --     local mini_snippets = require("mini.snippets")
  --     return {
  --       snippets = { mini_snippets.gen_loader.from_lang() },
  --
  --       -- Following the behavior of vim.snippets,
  --       -- the intended usage of <esc> is to be able to temporarily exit into normal mode for quick edits.
  --       --
  --       -- If you'd rather stop the snippet on <esc>, activate the line below in your own config:
  --       -- mappings = { stop = "<esc>" }, -- <c-c> by default, see :h MiniSnippets-session
  --
  --       expand = {
  --         select = function(snippets, insert)
  --           local select = expand_select_override or MiniSnippets.default_select
  --           select(snippets, insert)
  --         end,
  --       },
  --     }
  --   end,
  -- },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not LazyVim.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "benfowler/telescope-luasnip.nvim",
    lazy = true,
  },
}
