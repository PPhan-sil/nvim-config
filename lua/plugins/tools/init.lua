local conf = require("plugins.tools.config")

return {
  {
    "DreamMaoMao/yazi.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
    ft = "tex",
    config = conf.vimtex(),
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre "
        .. vim.fn.expand("~")
        .. "/Sync/Vault/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Sync/Vault/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = conf.obsidian(),
  },
}
