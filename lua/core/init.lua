local load_core = function()
  require("core.lazy")
  require("core.autocmds")
  require("core.options")
  require("core.keymaps")

  vim.api.nvim_command([[colorscheme catppuccin-frappe]])
end

load_core()
