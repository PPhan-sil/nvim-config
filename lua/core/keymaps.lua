local util = require("core.util")

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Plugin Comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment" })
-- Lazy & LSP
vim.keymap.set("n", "<leader>ll", "<cmd>:Lazy<cr>")
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>")
-- Alpha
vim.keymap.set("n", "<leader>a", "<cmd>Alpha<cr>", { desc = "Dashboard" })
-- ZenMode
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })
-- SymbolsOutline
vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
-- Vimtex
vim.keymap.set("n", "<leader>\\l", "<cmd>VimtexCompile<cr>", { desc = "Latex" })
-- Make
vim.keymap.set("n", "<leader>\\\\", "<cmd>make<cr>", { desc = "Make" })
vim.keymap.set("n", "<leader>\\r", "<cmd>make run<cr>", { desc = "Make & Run" })
-- Markdown Preview
vim.keymap.set("n", "<leader>\\m", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown" })
-- Telescope
vim.keymap.set("n", "<leader>sp", "<cmd>Telescope projects<cr>", { desc = "Projects" })
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set(
  "n",
  "<leader>st",
  "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args{}<cr>",
  { desc = "Find text" }
)
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope git_files<cr>", { desc = "Git files" })
vim.keymap.set("n", "<leader>go", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Checkout branch" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Checkout commit" })
-- Nvimtree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Nvimtree" })
-- ToggleTerm
vim.keymap.set({ "n", "t" }, "<leader>t", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal" })
-- Other toggles
vim.keymap.set("n", "<leader>rf", require("plugins.lsp.formatting").toggle, { desc = "Format on Save" })
vim.keymap.set("n", "<leader>rs", function()
  util.toggle("spell")
end, { desc = "Spelling" })
vim.keymap.set("n", "<leader>rw", function()
  util.toggle("wrap")
end, { desc = "Word Wrap" })
vim.keymap.set("n", "<leader>rn", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "Line Numbers" })
-- Vim maps
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "<leader>w", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "H", "<cmd>bprev<cr>")
vim.keymap.set("n", "L", "<cmd>bnext<cr>")
vim.keymap.set("n", "<c-t>", "<cmd>enew<cr>")
vim.keymap.set("n", "<C-s>", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { remap = true })
vim.keymap.set("n", "<C-left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-right>", "<cmd>vertical resize +2<cr>")
vim.keymap.set("n", "<C-down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "N", "Nzzzv", { remap = true })
vim.keymap.set("n", "n", "nzzzv", { remap = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<leader>gg", function()
  util.float_term({ "lazygit" })
end, { desc = "Lazygit" })

-- LSP
vim.keymap.set("n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Diagnostic prev" })
vim.keymap.set("n", "g]", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Diagnostic next" })
vim.keymap.set("n", "gf", "<cmd>Lspsaga rename<cr>", { desc = "Find and replace" })
vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature" })
vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action" })
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek" })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition" })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
-- ["n|gh"] = map_cr("Lspsaga lsp_finder"):with_noremap():with_silent(),

-- Trouble
vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Diagnostics" })
