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

  -- todo-comments
  {
    "folke/todo-comments.nvim",
    keys = {
      { "]t", false }, -- Next Todo Comment
      { "[t", false }, -- Previous Todo Comment
      { "<leader>xt", false }, -- Todo (Trouble)
      { "<leader>xT", false }, -- Todo/Fix/Fixme (Trouble)
      { "<leader>st", false }, -- Todo
      { "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = conf.whichkey(),
    keys = {
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
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    opts = conf.neoscroll(),
  },

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
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false }, -- Mason
    },
    opts = conf.mason(),
  },

  -- Conform
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>cF", false }, -- Format Injected Langs
    },
    opts = {
      formatters_by_ft = {
        ["python"] = { "black" },
      },
    },
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    keys = {
      { "<leader>up", false }, -- Toggle Auto Pairs
    },
  },
}
