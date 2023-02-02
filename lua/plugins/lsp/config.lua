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
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })
  local mr = require("mason-registry")
  for _, tool in ipairs(plugin.ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

function config.cmp()
  local icons = {
    kind = require("icons").get("kind", false),
    type = require("icons").get("type", false),
    cmp = require("icons").get("cmp", false),
  }
  -- vim.api.nvim_command([[packadd cmp-tabnine]])
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local has_words_before = function()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local border = function(hl)
    return {
      { "╭", hl },
      { "─", hl },
      { "╮", hl },
      { "│", hl },
      { "╯", hl },
      { "─", hl },
      { "╰", hl },
      { "│", hl },
    }
  end

  local cmp_window = require("cmp.utils.window")

  cmp_window.info_ = cmp_window.info
  cmp_window.info = function(self)
    local info = self:info_()
    info.scrollable = false
    return info
  end

  local compare = require("cmp.config.compare")
  local lspkind = require("lspkind")
  local cmp = require("cmp")

  cmp.setup({
    window = {
      completion = {
        border = border("Normal"),
        max_width = 80,
        max_height = 20,
      },
      documentation = {
        border = border("CmpDocBorder"),
      },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        require("cmp-under-comparator").under,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          symbol_map = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp),
        })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "    (" .. strings[2] .. ")"
        return kind
      end,
    },
    -- You can set mappings if you want
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
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    -- You should specify your *installed* sources.
    sources = {
      {
        name = "nvim_lsp",
        keyword_length = 2,
        max_item_counts = 32,
      },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      { name = "spell" },
      { name = "tmux" },
      { name = "orgmode" },
      { name = "buffer" },
      { name = "latex_symbols" },
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

  require("lspsaga").setup({
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
      enable = false,
      separator = " " .. icons.ui.Separator,
      hide_keyword = true,
      show_file = false,
      color_mode = true,
    },
  })
end

return config
