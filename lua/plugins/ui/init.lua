local conf = require("plugins.ui.config")

return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    opts = { style = "moon" },
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    config = conf.catppuccin(),
  },

  -- Nord
  {
    "shaunsingh/nord.nvim",
    event = "VeryLazy",
    config = conf.nord(),
  },

  -- Edge
  {
    "sainnhe/edge",
    event = "VeryLazy",
    config = conf.edge(),
  },

  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    event = "VeryLazy",
  },

  -- Better `vim.notify()`
  {
    "rcarriga/nvim-notify",
    keys = {
      { "<leader>un", false }, -- Dismiss all Notifications
      {
        "<leader>qn",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = conf.nvim_notify(),
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      if not LazyVim.has("noice.nvim") then
        LazyVim.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    enabled = function()
      return LazyVim.pick.want() == "telescope"
    end,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", false }, -- Toggle Pin
      { "<leader>bP", false }, -- Delete Non-Pinned Buffers
      { "<leader>bo", false }, -- Delete Other Buffers
      { "<leader>br", false }, -- Delete Buffers to the Right
      { "<leader>bl", false }, -- Delete Buffers to the Left
      { "<S-h>", false }, -- Prev Buffer
      { "<S-l>", false }, -- Next Buffer
      { "[b", false }, -- Prev Buffer
      { "]b", false }, -- Next Buffer
      { "[B", false }, -- Move buffer prev
      { "]B", false }, -- Move buffer next
    },
    opts = conf.bufferline(),
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = conf.statusline(),
  },

  -- indent guides
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "LazyFile",
    config = conf.indentscope(),
    init = function()
      -- Disable for certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "dotooagenda",
          "flutterToolsOutline",
          "fugitive",
          "git",
          "gitcommit",
          "help",
          "neo-tree",
          "NvimTree",
          "TelescopePrompt",
          "Trouble",
          "lazy",
          "log",
          "markdown",
          "mason",
          "notify",
          "packer",
          "peekaboo",
          "startify",
          "todoist",
          "toggleterm",
          "txt",
          "lazyterm",
          "vimwiki",
          "vista",
          "", -- for all buffers without a file type
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      -- Disable for large files
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = function()
          if vim.fn.getfsize(vim.fn.expand("%:p")) > vim.g.bigfile_size then
            vim.b.miniindentscope_disable = true
          end
        end,
      })
    end,
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "folke/which-key.nvim",
      },
    },
    opts = conf.noice(),
    -- stylua: ignore
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc =
        "Redirect Cmdline"
      },
      {
        "<leader>snl",
        function() require("noice").cmd("last") end,
        desc =
        "Noice Last Message"
      },
      {
        "<leader>snh",
        function() require("noice").cmd("history") end,
        desc =
        "Noice History"
      },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      {
        "<leader>snd",
        function() require("noice").cmd("dismiss") end,
        desc =
        "Dismiss All"
      },
      {
        "<c-f>",
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll forward",
        mode = {
          "i", "n", "s" }
      },
      {
        "<c-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll backward",
        mode = {
          "i", "n", "s" }
      },
    },
    config = function(_, opts)
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },

  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = conf.dashboard(),
  },

  -- lsp symbol navigation for lualine
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      LazyVim.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = conf.navic(),
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = conf.scroll(),
  },

  -- Inline and cmp color previews
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = conf.highlightColors(),
  },

  -- Outline
  {
    "hedyhli/outline.nvim",
    keys = { { "<leader>m", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
    cmd = "Outline",
    opts = conf.outline(),
  },
}
