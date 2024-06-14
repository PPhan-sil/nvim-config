local config = {}

function config.markdown()
  return function()
    vim.fn["mkdp#util#install"]()
  end
end

function config.vimtex()
  local g = vim.g
  g.vimtex_view_method = "zathura"
end

function config.colorizer()
  return function()
    require("colorizer").setup({
      "css",
      "javascript",
      css = {
        css = true,
        css_fn = true,
      },
      html = {
        mode = "foreground",
        names = false,
      },
    })
  end
end

return config
