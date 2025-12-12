local conf = require("plugins.lsp.config")
local ruff = vim.g.lazyvim_python_ruff or "ruff"

return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   -- opts = conf.lsp(),
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     { "brenoprata10/nvim-highlight-colors", opts = {} },
  --   },
  --   opts = conf.cmp(),
  -- },
  --
  --
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = false },
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
              lineLength = 120,
            },
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
        ruff_lsp = {
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
      },
      setup = {
        [ruff] = function()
          Snacks.util.lsp.on({ name = ruff }, function(_, client)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {
      options = {
        notify_user_on_venv_activation = true,
      },
      search = {
        venvs = {
          command = "fd python$ ~/.pyenv",
        },
      },
    },
    --  Call config for Python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "modern",
      options = {
        show_source = {
          enabled = true, -- Enable showing source names
          if_many = false, -- Only show source if multiple sources exist for the same diagnostic
        },
        -- Enable diagnostics display in select mode (e.g., during auto-completion)
        enable_on_select = true,
      },
    },
    config = function(_, opts)
      require("tiny-inline-diagnostic").setup(opts)
    end,
  },
}
