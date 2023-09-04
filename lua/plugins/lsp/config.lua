local config = {}

function config.lspzero()
  return function()
    local lsp = require('lsp-zero').preset({})

    lsp.extend_cmp()

    lsp.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      lsp.default_keymaps({ buffer = bufnr })
    end)

    lsp.set_sign_icons({
      error = '',
      warn = '',
      hint = '',
      info = ''
    })
  end
end

function config.mason()
  return function()
    require('mason').setup({})
  end
end

function config.masonlspconfig()
  return function()
    local lsp = require('lsp-zero').preset({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'tsserver',
      },
      handlers = {
        lsp.default_setup,
        lua_ls = function()
          -- Configure lua language server
          require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls({}))
          -- Configure typescript language server
          require('lspconfig').tsserver.setup({})
        end,
      },
    })
  end
end

return config
