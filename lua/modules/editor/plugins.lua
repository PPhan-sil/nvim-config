local editor = {}
local conf = require("modules.editor.config")

editor["RRethy/vim-illuminate"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.illuminate,
}
editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufReadPost",
	config = conf.nvim_treesitter,
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["p00f/nvim-ts-rainbow"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["windwp/nvim-ts-autotag"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.autotag,
}
editor["karb94/neoscroll.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.neoscroll,
}
editor["akinsho/toggleterm.nvim"] = {
	opt = true,
	event = "UIEnter",
	config = conf.toggleterm,
}
editor["folke/zen-mode.nvim"] = {
	opt = true,
	event = "UIEnter",
	config = conf.zenMode,
}
editor["NvChad/nvim-colorizer.lua"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.nvim_colorizer,
}
editor["rmagatti/auto-session"] = {
	opt = true,
	cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
	config = conf.auto_session,
}
editor["max397574/better-escape.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.better_escape,
}
editor["mfussenegger/nvim-dap"] = {
	opt = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	module = "dap",
	config = conf.dap,
}
editor["rcarriga/nvim-dap-ui"] = {
	opt = true,
	after = "nvim-dap", -- Need to call setup after dap has been initialized.
	config = conf.dapui,
}
editor["sindrets/diffview.nvim"] = {
	opt = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}

editor["simrat39/symbols-outline.nvim"] = {
	opt = true,
	event = "UIEnter",
	config = conf.symbolsOutline,
}
editor["numToStr/Comment.nvim"] = {
	opt = true,
	event = "UIEnter",
	config = conf.comment,
}

return editor
