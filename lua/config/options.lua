vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- (3) Hide * markup for bold and italic (0) none
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 500
opt.ttimeoutlen = 0
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.wrap = false -- Disable line wrap
opt.winminwidth = 5 -- Minimum window width

opt.hidden = true
opt.wildignorecase = true
opt.wildignore =
	".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
opt.smarttab = true
opt.timeout = true
-- opt.ttimeout = true
opt.infercase = true
opt.hlsearch = true
opt.incsearch = true
opt.wrapscan = true
opt.startofline = false
opt.whichwrap = "h,l,<,>,[,],~"
opt.switchbuf = "useopen"
opt.backspace = "indent,eol,start"
opt.foldlevelstart = 99
opt.ruler = true
opt.cursorcolumn = false
opt.cmdheight = 1
opt.autoindent = true
opt.softtabstop = 2
opt.linebreak = true
opt.concealcursor = "niv"
opt.colorcolumn = "120"
opt.fillchars = { fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "indent"

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
