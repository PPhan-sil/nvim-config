local load_core = function()
  require("core.options")
  require("core.autocmds")
  require("core.keymaps")
  require("core.lazy")

  vim.api.nvim_command([[colorscheme catppuccin-frappe]])
end

load_core()
