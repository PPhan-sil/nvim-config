local conf = require("plugins.tools.config")

return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    config = conf.markdown(),
  },
  {
    "lervag/vimtex",
    ft = "tex",
    opts = conf.vimtex(),
  },
  {
    "norcalli/nvim-colorizer.lua",
    -- ft = "tex",
    config = conf.colorizer(),
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre /home/ipete/Documents/Obsidian/Academics/**.md",
      "BufNewFile /home/ipete/Documents/Obsidian/Academics/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Academics",
          path = "~/Documents/Obsidian/Academics",
        },
      },

    },
  }
}
