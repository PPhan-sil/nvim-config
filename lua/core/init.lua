local load_core = function()
  require("core.options")
  require("core.autocmds")
  require("core.keymaps")
  ---@diagnostic disable-next-line: different-requires
  require("core.lazy")

  vim.api.nvim_command([[colorscheme catppuccin-frappe]])
end

load_core()
