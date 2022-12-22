local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
	-- Vim map
	["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent(),
	["n|<C-x>k"] = map_cr("bdelete"):with_noremap():with_silent(),
	["n|<C-s>"] = map_cu("write"):with_noremap(),
	["n|n"] = map_cmd("nzzzv"):with_noremap(),
	["n|N"] = map_cmd("Nzzzv"):with_noremap(),
	["n|J"] = map_cmd("mzJ`z"):with_noremap(),
	["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
	["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
	["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap(),
	["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap(),
	["n|<C-2>"] = map_cr("vertical resize -5"):with_silent(),
	["n|<C-3>"] = map_cr("vertical resize +5"):with_silent(),
	["n|<C-S-h>"] = map_cr("resize -2"):with_silent(),
	["n|<C-S-l>"] = map_cr("resize +2"):with_silent(),
	["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"),
	-- Insert
	["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap(),
	-- command line
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
	["c|w!!"] = map_cmd("execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"),
	-- Visual
	["v|J"] = map_cmd(":m '>+1<cr>gv=gv"),
	["v|K"] = map_cmd(":m '<-2<cr>gv=gv"),
	["v|<"] = map_cmd("<gv"),
	["v|>"] = map_cmd(">gv"),
}

bind.nvim_load_mapping(def_map)
