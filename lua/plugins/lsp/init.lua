local conf = require("plugins.lsp.config")

return {
  {
    "neovim/nvim-lspconfig",
    opts = conf.lsp(),
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "brenoprata10/nvim-highlight-colors", opts = {} },
    },
    opts = conf.cmp(),
  },
}
