local conf = require("plugins.lsp.config")

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", config = { automatic_installation = true } },
    },
    servers = nil,
    config = conf.lspconfig,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = conf.null_ls,
  },

  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<cmd>Mason<cr>", desc = "Mason" } },
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
    },
    config = conf.mason,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    config = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        remap = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "lukas-reineke/cmp-under-comparator",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "kdheepak/cmp-latex-symbols",
    },
    config = conf.cmp,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = conf.lspsaga,
  },
  {
    "ray-x/lsp_signature.nvim",
  },
}
