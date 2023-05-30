local config = {}

function config.markdown()
	return function()
		vim.fn["mkdp#util#install"]()
	end
end

function config.vimtex()
	local g = vim.g
	g.vimtex_view_method = "zathura"
	g.vimtex_quickfix_enabled = 0
end

return config
