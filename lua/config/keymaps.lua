-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("v", "<S-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<S-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
if LazyVim.has("bufferline.nvim") then
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
  map("n", "<C-Left>", "<cmd>BufferLineMovePrev<cr>", { desc = "Next Buffer Prev" })
  map("n", "<C-Right>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer Next" })
else
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
map("n", "<leader>w", LazyVim.ui.bufremove, { desc = "Delete Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment" })

-- Folds
map("n", "<leader>f", "za", { remap = true, desc = "Fold" })

-- lazy/lsp/mason
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>li", "<cmd>LspInfo<cr>")
map("n", "<leader>ls", "<cmd>LspStart<cr>")
map("n", "<leader>lr", "<cmd>LspRestart<cr>")
map("n", "<leader>lm", "<cmd>Mason<cr>")

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
-- map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
LazyVim.toggle.map("<leader>rf", LazyVim.toggle.format())
LazyVim.toggle.map("<leader>rF", LazyVim.toggle.format(true))
LazyVim.toggle.map("<leader>rs", LazyVim.toggle("spell", { name = "Spelling" }))
LazyVim.toggle.map("<leader>rw", LazyVim.toggle("wrap", { name = "Wrap" }))
LazyVim.toggle.map("<leader>rL", LazyVim.toggle("relativenumber", { name = "Relative Number" }))
LazyVim.toggle.map("<leader>rd", LazyVim.toggle.diagnostics)
LazyVim.toggle.map("<leader>rl", LazyVim.toggle.number)
LazyVim.toggle.map( "<leader>rc", LazyVim.toggle("conceallevel", { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } }))
LazyVim.toggle.map("<leader>rt", LazyVim.toggle.treesitter)
LazyVim.toggle.map("<leader>rb", LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" }))
if vim.lsp.inlay_hint then
  LazyVim.toggle.map("<leader>rh", LazyVim.toggle.inlay_hints)
end

-- obsidian
map("n", "<leader>ot", function() return require("obsidian").util.toggle_checkbox() end, { desc = "Toggle Checkbox" })
map("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New Note" })
map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian" })
map("n", "<leader>op", "<cmd>ObsidianPasteImg<cr>", { desc = "Paste Image" })
map("n", "<leader>ost", "<cmd>ObsidianTags<cr>", { desc = "Search Tags" })
map("n", "<leader>osf", "<cmd>ObsidianSearch<cr>", { desc = "Search Text" })
map("v", "<leader>ola", "<cmd>ObsidianLink<cr>", { desc = "Add Link" })
map("v", "<leader>olc", "<cmd>ObsidianLinkNew<cr>", { desc = "Create Link" })
LazyVim.toggle.map( "<leader>oc", LazyVim.toggle("conceallevel", { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } }))

-- lazygit
map("n", "<leader>gg", function() LazyVim.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gG", function() LazyVim.lazygit() end, { desc = "Lazygit (cwd)" })
map("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
map("n", "<leader>gB", LazyVim.lazygit.browse, { desc = "Git Browse" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
map("n", "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Preview Hunk Inline" })

map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  LazyVim.lazygit({args = { "-f", vim.trim(git_path) }})
end, { desc = "Lazygit Current File History" })

map("n", "<leader>gl", function()
  LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
end, { desc = "Lazygit Log" })
map("n", "<leader>gL", function()
  LazyVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- LazyVim Changelog
map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
map("n", "<F4>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal" })
map("t", "<F4>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Yazi (file manager)
map("n", "<leader>y", "<cmd>Yazi<CR>", { desc = "Toggle Yazi" })

-- Nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Nvimtree" })

-- Highlight-colors
map("n", "<leader>rp", "<cmd>HighlightColors toggle<cr>", { desc = "Highlight Colors" })

-- ZenMode
map("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })

-- Dashboard
map("n", "<leader>a", "<cmd>Dashboard<cr>", { desc = "Dashboard" })

-- Vimtex
map("n", "<leader>\\l", "<cmd>VimtexCompile<cr>", { desc = "Latex" })

-- Make
map("n", "<leader>\\\\", "<cmd>make<cr>", { desc = "Make" })
map("n", "<leader>\\r", "<cmd>make run<cr>", { desc = "Make & Run" })

-- Markdown Preview
map("n", "<leader>\\m", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown" })
