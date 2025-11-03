return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      defaults = {
        keymaps = false, -- Disable LazyVim keymaps
      },
    },
  },
  -- Disable Plugins from LazyVim
  {
    "folke/todo-comments.nvim",
    enabled = false,
  },
  -- {
  --   "folke/flash.nvim",
  --   enabled = false,
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  -- {
  --   "echasnovski/mini.ai",
  --   enabled = false,
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "Bilal2453/luvit-meta",
    enabled = false,
  },
}
