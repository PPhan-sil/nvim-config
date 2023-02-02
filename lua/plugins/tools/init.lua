local conf = require("plugins.tools.config")
return {
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "debugloop/telescope-undo.nvim",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  {
    "debugloop/telescope-undo.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = conf.telescope,
  },
  {
    "ahmedkhalf/project.nvim",
    config = conf.project,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
  },
  {
    "kkharji/sqlite.lua",
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  {
    "michaelb/sniprun",
    cmd = { "SnipRun" },
    config = conf.sniprun,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = conf.trouble,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = conf.whichkey,
  },
  {
    "stevearc/dressing.nvim",
    init = function()
      local lazy = require("lazy")
      vim.ui.select = function(...)
        lazy.load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        lazy.load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    config = conf.dressing,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    config = conf.markdown,
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = conf.vimtex,
  },
}
