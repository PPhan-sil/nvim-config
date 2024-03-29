if not vim.g.vscode then
	return {}
end

local enabled = {
	"flit.nvim",
	"lazy.nvim",
	"leap.nvim",
	"mini.ai",
	"mini.comment",
	"mini.pairs",
	"mini.surround",
	"nvim-treesitter",
	"nvim-treesitter-textobjects",
	"nvim-ts-context-commentstring",
	"vim-repeat",
	"LazyVim",
}

local Config = require("lazy.core.config")
local Plugin = require("lazy.core.plugin")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false

-- HACK: disable all plugins except the ones we want
local fix_disabled = Plugin.Spec.fix_disabled
function Plugin.Spec.fix_disabled(self)
	for _, plugin in pairs(self.plugins) do
		if not (vim.tbl_contains(enabled, plugin.name) or plugin.vscode) then
			plugin.enabled = false
		end
	end
	fix_disabled(self)
end

-- HACK: don't clean plugins in vscode
local update_state = Plugin.update_state
function Plugin.update_state()
	update_state()
	Config.to_clean = {}
end

return {
	{
		"LazyVim/LazyVim",
		config = function(_, opts)
			opts = opts or {}
			-- disable the colorscheme
			opts.colorscheme = function() end
			require("lazyvim").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { highlight = { enable = false } },
	},
}
