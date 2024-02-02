local Util = require("util")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
if Util.has("bufferline.nvim") then
	map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
	map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

map("n", "n", "nzzzv", { remap = true, desc = "Next search result" })
map("x", "n", "nzzzv", { remap = true, desc = "Next search result" })
map("o", "n", "nzzzv", { remap = true, desc = "Next search result" })
map("n", "N", "Nzzzv", { remap = true, desc = "Prev search result" })
map("x", "N", "Nzzzv", { remap = true, desc = "Prev search result" })
map("o", "N", "Nzzzv", { remap = true, desc = "Prev search result" })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>ll", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
--
-- map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- if not Util.has("trouble.nvim") then
-- 	map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
-- 	map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
-- end

-- stylua: ignore start

-- toggle options
map("n", "<leader>rf", require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>rs", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>rw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>rl", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
map("n", "<leader>rd", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>rc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
map("n", "<leader>rn", function() return require("obsidian").util.toggle_checkbox() end, { desc = "Toggle Checkbox"})

-- lazygit
map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Util.float_term({ "lazygit" }, {esc_esc = false}) end, { desc = "Lazygit (cwd)" })

-- floating terminal
map({ "n", "t" }, "<leader>t", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
-- map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
-- map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
-- map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
-- map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })

-- Nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Nvimtree" })

-- ZenMode
map("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })

-- Comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment" })

-- Folds
map("n", "<leader>f", "za", { remap = true, desc = "Fold" })

-- Alpha
map("n", "<leader>a", "<cmd>Alpha<cr>", { desc = "Dashboard" })

-- LSP
map("n", "<leader>ll", "<cmd>:Lazy<cr>")
map("n", "<leader>li", "<cmd>LspInfo<cr>")
map("n", "<leader>lr", "<cmd>LspRestart<cr>")

-- Vimtex
map("n", "<leader>\\l", "<cmd>VimtexCompile<cr>", { desc = "Latex" })

-- Make
map("n", "<leader>\\\\", "<cmd>make<cr>", { desc = "Make" })
map("n", "<leader>\\r", "<cmd>make run<cr>", { desc = "Make & Run" })

-- Markdown Preview
map("n", "<leader>\\m", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown" })
