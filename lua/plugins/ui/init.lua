local conf = require("plugins.ui.config")

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = conf.catppuccin,
  },
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    priority = 1000,
  },
  {
    "shaunsingh/nord.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_cursorline_transparent = false
      vim.g.nord_disable_background = false
      vim.g.nord_enable_sidebar_background = true
      vim.g.nord_italic = true
    end,
  },
  {
    "sainnhe/edge",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      vim.g.edge_style = "neon"
      vim.g.edge_enable_italic = 1
      vim.g.edge_disable_italic_comment = 1
      vim.g.edge_show_eob = 1
      vim.g.edge_better_performance = 1
      vim.g.edge_transparent_background = 1
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    event = "VeryLazy",
    priority = 1000,
  },
  "kyazdani42/nvim-web-devicons",
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = conf.neodim,
  },
  {
    "rcarriga/nvim-notify",
    config = conf.notify,
  },
  {
    "hoob3rt/lualine.nvim",
    event = "VeryLazy",
    override = function(config)
      return config
    end,
    config = conf.lualine,
  },
  {
    "goolord/alpha-nvim",
    event = "BufWinEnter",
    config = conf.alpha,
  },
  {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
    },
    config = conf.nvimtree,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = conf.gitsigns,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = conf.indent_blankline,
  },
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPost",
    config = conf.bufferline,
  },
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPost",
    config = function()
      require("scrollview").setup({})
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "BufReadPost",
    config = conf.fidget,
  },
}
