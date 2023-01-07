local config = {}

function config.lspconfig(plugin)
  -- setup formatting and keymaps
  require("core.util").on_attach(function(client, buffer)
    require("plugins.lsp.formatting").on_attach(client, buffer)
    require("plugins.lsp.keymaps").on_attach(client, buffer)
  end)

  -- diagnostics
  for name, icon in pairs(require("icons").get("diagnostics")) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  })

  -- lspconfig
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  local servers = plugin.servers or require("plugins.lsp.servers")
  for server, opts in pairs(servers) do
    opts.capabilities = capabilities
    require("lspconfig")[server].setup(opts)
  end
end

function config.null_ls()
  local nls = require("null-ls")
  nls.setup({
    sources = {
      -- nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      nls.builtins.diagnostics.flake8,
    },
  })
end

function config.mason(plugin)
  require("mason").setup()
  local mr = require("mason-registry")
  for _, tool in ipairs(plugin.ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

function config.cmp()
  local cmp = require("cmp")
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local has_words_before = function()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp", max_item_count = 8 },
      { name = "luasnip", max_item_count = 8 },
      { name = "buffer", max_item_count = 8 },
      { name = "path", max_item_count = 8 },
      { name = "emoji", max_item_count = 8 },
    }),
    formatting = {
      format = function(_, item)
        local icons = require("icons").get("kind")
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
  })
end

function config.lspsaga()
  local icons = {
    diagnostics = require("icons").get("diagnostics", true),
    kind = require("icons").get("kind", true),
    type = require("icons").get("type", true),
    ui = require("icons").get("ui", true),
  }

  local function set_sidebar_icons()
    -- Set icons for sidebar.
    local diagnostic_icons = {
      Error = icons.diagnostics.Error_alt,
      Warn = icons.diagnostics.Warning_alt,
      Info = icons.diagnostics.Information_alt,
      Hint = icons.diagnostics.Hint_alt,
    }
    for type, icon in pairs(diagnostic_icons) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
  end

  local function get_palette()
    if vim.g.colors_name == "catppuccin" then
      -- If the colorscheme is catppuccin then use the palette.
      return require("catppuccin.palettes").get_palette()
    else
      -- Default behavior: return lspsaga's default palette.
      local palette = require("lspsaga.lspkind").colors
      palette.peach = palette.orange
      palette.flamingo = palette.orange
      palette.rosewater = palette.yellow
      palette.mauve = palette.violet
      palette.sapphire = palette.blue
      palette.maroon = palette.orange

      return palette
    end
  end

  set_sidebar_icons()

  local colors = get_palette()

  require("lspsaga").init_lsp_saga({
    diagnostic_header = {
      icons.diagnostics.Error_alt,
      icons.diagnostics.Warning_alt,
      icons.diagnostics.Information_alt,
      icons.diagnostics.Hint_alt,
    },
    custom_kind = {
      -- Kind
      Class = { icons.kind.Class, colors.yellow },
      Constant = { icons.kind.Constant, colors.peach },
      Constructor = { icons.kind.Constructor, colors.sapphire },
      Enum = { icons.kind.Enum, colors.yellow },
      EnumMember = { icons.kind.EnumMember, colors.teal },
      Event = { icons.kind.Event, colors.yellow },
      Field = { icons.kind.Field, colors.teal },
      File = { icons.kind.File, colors.rosewater },
      Function = { icons.kind.Function, colors.blue },
      Interface = { icons.kind.Interface, colors.yellow },
      Key = { icons.kind.Keyword, colors.red },
      Method = { icons.kind.Method, colors.blue },
      Module = { icons.kind.Module, colors.blue },
      Namespace = { icons.kind.Namespace, colors.blue },
      Number = { icons.kind.Number, colors.peach },
      Operator = { icons.kind.Operator, colors.sky },
      Package = { icons.kind.Package, colors.blue },
      Property = { icons.kind.Property, colors.teal },
      Struct = { icons.kind.Struct, colors.yellow },
      TypeParameter = { icons.kind.TypeParameter, colors.maroon },
      Variable = { icons.kind.Variable, colors.peach },
      -- Type
      Array = { icons.type.Array, colors.peach },
      Boolean = { icons.type.Boolean, colors.peach },
      Null = { icons.type.Null, colors.yellow },
      Object = { icons.type.Object, colors.yellow },
      String = { icons.type.String, colors.green },
      -- ccls-specific iconss.
      TypeAlias = { icons.kind.TypeAlias, colors.green },
      Parameter = { icons.kind.Parameter, colors.blue },
      StaticMethod = { icons.kind.StaticMethod, colors.peach },
    },
    code_action_lightbulb = {
      enable = false,
      enable_in_insert = true,
      cache_code_action = true,
      sign = true,
      update_time = 150,
      sign_priority = 20,
      virtual_text = true,
    },
    symbol_in_winbar = {
      enable = true,
      in_custom = false,
      separator = " " .. icons.ui.Separator,
      show_file = true,
      -- define how to customize filename, eg: %:., %
      -- if not set, use default value `%:t`
      -- more information see `vim.fn.expand` or `expand`
      -- ## only valid after set `show_file = true`
      file_formatter = "%:., %",
      click_support = function(node, clicks, button, modifiers)
        -- To see all avaiable details: vim.pretty_print(node)
        local st = node.range.start
        local en = node.range["end"]
        if button == "l" then
          if clicks == 2 then
            -- double left click to do nothing
          else -- jump to node's starting line+char
            vim.fn.cursor(st.line + 1, st.character + 1)
          end
        elseif button == "r" then
          if modifiers == "s" then
            print("lspsaga") -- shift right click to print "lspsaga"
          end -- jump to node's ending line+char
          vim.fn.cursor(en.line + 1, en.character + 1)
        elseif button == "m" then
          -- middle click to visual select node
          vim.fn.cursor(st.line + 1, st.character + 1)
          vim.api.nvim_command([[normal v]])
          vim.fn.cursor(en.line + 1, en.character + 1)
        end
      end,
    },
  })
end

return config
