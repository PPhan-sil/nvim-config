local servers = {
  bashls = {},
  clangd = {},
  cssls = {},
  tsserver = {},
  html = {
    cmd = { "html-languageserver", "--stdio" },
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = { css = true, javascript = true },
    },
    settings = {},
    single_file_support = true,
  },
  jsonls = {
    flags = { debounce_text_changes = 500 },
    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json",
            },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = { ".eslintrc", ".eslintrc.json" },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            fileMatch = {
              ".babelrc",
              ".babelrc.json",
              "babel.config.json",
            },
            url = "https://json.schemastore.org/babelrc.json",
          },
          {
            fileMatch = { "lerna.json" },
            url = "https://json.schemastore.org/lerna.json",
          },
          {
            fileMatch = {
              ".stylelintrc",
              ".stylelintrc.json",
              "stylelint.config.json",
            },
            url = "http://json.schemastore.org/stylelintrc.json",
          },
          {
            fileMatch = { "/.github/workflows/*" },
            url = "https://json.schemastore.org/github-workflow.json",
          },
        },
      },
    },
  },
  pyright = {},
  yamlls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  tailwindcss = {},
  texlab = {},
  astro = {},
}

return servers
