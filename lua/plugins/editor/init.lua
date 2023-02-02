local conf = require("plugins.editor.config")
return {
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = conf.illuminate,
  },
  {
    "windwp/nvim-autopairs",
    event = "BufReadPost",
    config = conf.autopairs,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    config = conf.treesitter,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "mfussenegger/nvim-ts-hint-textobject",
  },
  {
    "windwp/nvim-ts-autotag",
    config = conf.autotag,
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    config = conf.neoscroll,
  },
  {
    "akinsho/toggleterm.nvim",
    event = "UIEnter",
    config = conf.toggleterm,
  },
  {
    "folke/zen-mode.nvim",
    event = "UIEnter",
    config = conf.zen,
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerToggle",
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
    config = conf.colorizer,
  },
  {
    "rmagatti/auto-session",
    cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
    config = conf.autoSession,
  },
  {
    "max397574/better-escape.nvim",
    event = "BufReadPost",
    config = conf.betterEscape,
  },
  {
    "mfussenegger/nvim-dap",
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    config = conf.dap,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = conf.dapUI,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },
  {
    "simrat39/symbols-outline.nvim",
    event = "UIEnter",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "UIEnter",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
      { "luukvbaal/statuscol.nvim", config = conf.statuscol },
    },
    config = conf.ufo,
  },
  {
    "mrshmllow/document-color.nvim",
    ft = {
      "typescriptreact",
      "javacriptreact",
      "astro",
    },
    config = conf.documentColor,
  },
}
