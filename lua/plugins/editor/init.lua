local conf = require("plugins.editor.config")
local Util = require("util")

return {
	-- file explorer
	{
		"kyazdani42/nvim-tree.lua",
		cmd = {
			"NvimTreeToggle",
			"NvimTreeOpen",
			"NvimTreeFindFile",
			"NvimTreeFindFileToggle",
			"NvimTreeRefresh",
		},
		config = conf.nvimtree(),
	},

	-- search/replace in multiple files
	{
		"nvim-pack/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
	},

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		keys = {
			{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>sf", Util.telescope("files"), desc = "Find Files" },
			{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{ "<leader>st", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			{ "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
		},
		opts = conf.telescope(),
	},

	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = conf.whichkey(),
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults, { prefix = "<leader>" })
		end,
	},

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = conf.gitsigns(),
	},

	-- references
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = conf.illuminate(),
	},

	-- buffer remove
	{
		"echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>w", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
    },
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = conf.trouble(),
		keys = {
			{ "<leader>x", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			-- 	{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			-- 	{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			-- 	{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			-- 	{
			-- 		"[q",
			-- 		function()
			-- 			if require("trouble").is_open() then
			-- 				require("trouble").previous({ skip_groups = true, jump = true })
			-- 			else
			-- 				vim.cmd.cprev()
			-- 			end
			-- 		end,
			-- 		desc = "Previous trouble/quickfix item",
			-- 	},
			-- 	{
			-- 		"]q",
			-- 		function()
			-- 			if require("trouble").is_open() then
			-- 				require("trouble").next({ skip_groups = true, jump = true })
			-- 			else
			-- 				vim.cmd.cnext()
			-- 			end
			-- 		end,
			-- 		desc = "Next trouble/quickfix item",
			-- 	},
		},
	},

	-- Smooth scroll
	{
		"karb94/neoscroll.nvim",
		event = "BufReadPost",
		opts = conf.neoscroll(),
	},

	-- Zen Mode
	{
		"folke/zen-mode.nvim",
		event = "UIEnter",
		opts = conf.zen(),
	},

	-- Use jj for esc
	{
		"max397574/better-escape.nvim",
		event = "BufReadPost",
		opts = conf.betterEscape(),
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		event = "UIEnter",
		config = function()
			require("Comment").setup()
		end,
		keys = {
			{ "<leader>/", "gcc", desc = "Comment" },
		},
	},

	-- Toggle Term
	{
		"akinsho/toggleterm.nvim",
		event = "UIEnter",
		config = conf.toggleterm(),
	},

	-- Better Folds
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		dependencies = {
			"kevinhwang91/promise-async",
			{ "luukvbaal/statuscol.nvim", config = conf.statuscol() },
		},
		config = conf.ufo(),
	},
}
