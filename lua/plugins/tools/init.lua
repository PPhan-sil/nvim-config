local conf = require("plugins.tools.config")

return {
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		opts = conf.markdown(),
	},
	{
		"lervag/vimtex",
		ft = "tex",
		opts = conf.vimtex(),
	},
}
