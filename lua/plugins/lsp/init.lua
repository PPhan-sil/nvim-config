local conf = require("plugins.lsp.config")

return {
  -- lspconfig
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    lazy = true,
    config = conf.lspzero(),
  },

  {
    'williamboman/mason.nvim',
    config = conf.mason(),
  },
  {
    'williamboman/mason-lspconfig.nvim',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = conf.masonlspconfig(),
  },

  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    opts = {
      autoformat = true,
      format_notify = false,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
    },
    config = function(_, opts)
      require("plugins.lsp.format").setup(opts)
    end,
  },
}
