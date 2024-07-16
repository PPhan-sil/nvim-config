local conf = require("plugins.lsp.config")

return {
  {
    'williamboman/mason.nvim',
    config = conf.mason(),
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   -- event = "LazyFile",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "mason.nvim",
  --     { "williamboman/mason-lspconfig.nvim", config = function() end },
  --   },
  --   ---@class PluginLspOpts
  --   opts = function()
  --     return {
  --       -- options for vim.diagnostic.config()
  --       ---@type vim.diagnostic.Opts
  --       diagnostics = {
  --         underline = true,
  --         update_in_insert = false,
  --         virtual_text = {
  --           spacing = 4,
  --           source = "if_many",
  --           prefix = "●",
  --           -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
  --           -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
  --           -- prefix = "icons",
  --         },
  --         severity_sort = true,
  --       },
  --       -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  --       -- Be aware that you also will need to properly configure your LSP server to
  --       -- provide the inlay hints.
  --       inlay_hints = {
  --         enabled = true,
  --         exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
  --       },
  --       -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
  --       -- Be aware that you also will need to properly configure your LSP server to
  --       -- provide the code lenses.
  --       codelens = {
  --         enabled = false,
  --       },
  --       -- Enable lsp cursor word highlighting
  --       document_highlight = {
  --         enabled = true,
  --       },
  --       -- add any global capabilities here
  --       capabilities = {
  --         workspace = {
  --           fileOperations = {
  --             didRename = true,
  --             willRename = true,
  --           },
  --         },
  --       },
  --       -- options for vim.lsp.buf.format
  --       -- `bufnr` and `filter` is handled by the LazyVim formatter,
  --       -- but can be also overridden when specified
  --       format = {
  --         formatting_options = nil,
  --         timeout_ms = nil,
  --       },
  --       -- LSP Server Settings
  --       ---@type lspconfig.options
  --       servers = {
  --         lua_ls = {
  --           -- mason = false, -- set to false if you don't want this server to be installed with mason
  --           -- Use this to add any additional keymaps
  --           -- for specific lsp servers
  --           -- ---@type LazyKeysSpec[]
  --           -- keys = {},
  --           settings = {
  --             Lua = {
  --               workspace = {
  --                 checkThirdParty = false,
  --               },
  --               codeLens = {
  --                 enable = true,
  --               },
  --               completion = {
  --                 callSnippet = "Replace",
  --               },
  --               doc = {
  --                 privateName = { "^_" },
  --               },
  --               hint = {
  --                 enable = true,
  --                 setType = false,
  --                 paramType = true,
  --                 paramName = "Disable",
  --                 semicolon = "Disable",
  --                 arrayIndex = "Disable",
  --               },
  --             },
  --           },
  --         },
  --       },
  --       -- you can do any additional lsp server setup here
  --       -- return true if you don't want this server to be setup with lspconfig
  --       ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --       setup = {
  --         -- example to setup with typescript.nvim
  --         -- tsserver = function(_, opts)
  --         --   require("typescript").setup({ server = opts })
  --         --   return true
  --         -- end,
  --         -- Specify * to use this function as a fallback for any server
  --         -- ["*"] = function(server, opts) end,
  --       },
  --     }
  --   end,
  --   ---@param opts PluginLspOpts
  --   config = function(_, opts)
  --     -- setup autoformat
  --     LazyVim.format.register(LazyVim.lsp.formatter())
  --
  --     -- setup keymaps
  --     LazyVim.lsp.on_attach(function(client, buffer)
  --       require("plugins.lsp.keymaps").on_attach(client, buffer)
  --     end)
  --
  --     LazyVim.lsp.setup()
  --     LazyVim.lsp.on_dynamic_capability(require("plugins.lsp.keymaps").on_attach)
  --
  --     -- diagnostics signs
  --     if vim.fn.has("nvim-0.10.0") == 0 then
  --       if type(opts.diagnostics.signs) ~= "boolean" then
  --         for severity, icon in pairs(opts.diagnostics.signs.text) do
  --           local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
  --           name = "DiagnosticSign" .. name
  --           vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  --         end
  --       end
  --     end
  --
  --     if vim.fn.has("nvim-0.10") == 1 then
  --       -- inlay hints
  --       if opts.inlay_hints.enabled then
  --         LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
  --           if
  --               vim.api.nvim_buf_is_valid(buffer)
  --               and vim.bo[buffer].buftype == ""
  --               and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
  --           then
  --             LazyVim.toggle.inlay_hints(buffer, true)
  --           end
  --         end)
  --       end
  --
  --       -- code lens
  --       if opts.codelens.enabled and vim.lsp.codelens then
  --         LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
  --           vim.lsp.codelens.refresh()
  --           vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  --             buffer = buffer,
  --             callback = vim.lsp.codelens.refresh,
  --           })
  --         end)
  --       end
  --     end
  --
  --     if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
  --       opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
  --           or function(diagnostic)
  --             local icons = LazyVim.config.icons.diagnostics
  --             for d, icon in pairs(icons) do
  --               if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
  --                 return icon
  --               end
  --             end
  --           end
  --     end
  --
  --     vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
  --
  --     local servers = opts.servers
  --     local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  --     local capabilities = vim.tbl_deep_extend(
  --       "force",
  --       {},
  --       vim.lsp.protocol.make_client_capabilities(),
  --       has_cmp and cmp_nvim_lsp.default_capabilities() or {},
  --       opts.capabilities or {}
  --     )
  --
  --     local function setup(server)
  --       local server_opts = vim.tbl_deep_extend("force", {
  --         capabilities = vim.deepcopy(capabilities),
  --       }, servers[server] or {})
  --
  --       if opts.setup[server] then
  --         if opts.setup[server](server, server_opts) then
  --           return
  --         end
  --       elseif opts.setup["*"] then
  --         if opts.setup["*"](server, server_opts) then
  --           return
  --         end
  --       end
  --       require("lspconfig")[server].setup(server_opts)
  --     end
  --
  --     -- get all the servers that are available through mason-lspconfig
  --     local have_mason, mlsp = pcall(require, "mason-lspconfig")
  --     local all_mslp_servers = {}
  --     if have_mason then
  --       all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  --     end
  --
  --     local ensure_installed = {} ---@type string[]
  --     for server, server_opts in pairs(servers) do
  --       if server_opts then
  --         server_opts = server_opts == true and {} or server_opts
  --         if server_opts.enabled ~= false then
  --           -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
  --           if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
  --             setup(server)
  --           else
  --             ensure_installed[#ensure_installed + 1] = server
  --           end
  --         end
  --       end
  --     end
  --     if have_mason then
  --       mlsp.setup({
  --         ensure_installed = vim.tbl_deep_extend(
  --           "force",
  --           ensure_installed
  --         ),
  --         handlers = { setup },
  --       })
  --     end
  --   end,
  -- }
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason.nvim" },
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = false,
        dependencies = { "nvim-lspconfig" }
      },
      { "folke/neodev.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- Enable this to show formatters used in a notification
      -- Useful for debugging formatter issues
      format_notify = false,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        tsserver = {
          init_options = {
            preferences = {
              disableSuggestions = true,
            }
          }
        },
        -- pylsp = {
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         -- formatter options
        --         black = { enabled = true },
        --         autopep8 = { enabled = false },
        --         yapf = { enabled = false },
        --         -- linter options
        --         pylint = { enabled = true },
        --         pyflakes = { enabled = false },
        --         pycodestyle = { enabled = false },
        --         pydocstyle = { enabled = false },
        --         mccabe = { enabled = false },
        --         flake8 = { enabled = false }
        --       }
        --     }
        --   }
        -- },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeys[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      local Util = require("util")

      if Util.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end
      -- setup autoformat
      require("plugins.lsp.format").setup(opts)
      -- setup formatting and keymaps
      Util.on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      -- diagnostics
      for name, icon in pairs(require("config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

      if opts.inlay_hints.enabled and inlay_hint then
        Util.on_attach(function(client, buffer)
          if client.supports_method('textDocument/inlayHint') then
            inlay_hint(buffer, true)
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
            or function(diagnostic)
              local icons = require("config").icons.diagnostics
              for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                  return icon
                end
              end
            end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = { "lua_ls", "tsserver", "texlab" } ---@type string[]
      -- local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Util.lsp_disable("tsserver", is_deno)
        Util.lsp_disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },
}
