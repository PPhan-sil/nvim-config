vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

require("core.statusCol")

local function load_options()
  local global_local = {
    termguicolors = true,
    hidden = true,
    fileformats = "unix,mac,dos",
    encoding = "utf-8",
    clipboard = "unnamedplus",
    wildignorecase = true,
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    backup = false,
    writebackup = false,
    swapfile = false,
    history = 2000,
    shada = "!,'300,<50,@100,s10,h",
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
    smarttab = true,
    shiftround = true,
    timeout = true,
    ttimeout = true,
    timeoutlen = 300,
    ttimeoutlen = 0,
    updatetime = 50,
    redrawtime = 1500,
    ignorecase = true,
    smartcase = true,
    infercase = true,
    hlsearch = true,
    incsearch = true,
    wrapscan = true,
    complete = ".,w,b,k",
    inccommand = "nosplit",
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --hidden --vimgrep --smart-case --",
    breakat = [[\ \	;:,!?]],
    startofline = false,
    whichwrap = "h,l,<,>,[,],~",
    splitbelow = true,
    splitright = true,
    switchbuf = "useopen",
    backspace = "indent,eol,start",
    diffopt = "filler,iwhite,internal,algorithm:patience",
    completeopt = "menuone,noselect",
    jumpoptions = "stack",
    showmode = false,
    shortmess = "aoOTIcF",
    scrolloff = 8,
    sidescrolloff = 8,
    mouse = "a",
    mousescroll = "ver:4,hor:6",
    foldlevelstart = 99,
    ruler = true,
    cursorline = true,
    cursorcolumn = false,
    list = true,
    showtabline = 2,
    winwidth = 30,
    winminwidth = 10,
    pumheight = 10,
    helpheight = 12,
    previewheight = 12,
    showcmd = false,
    cmdheight = 1, -- 0, 1, 2
    cmdwinheight = 5,
    equalalways = false,
    laststatus = 2,
    display = "lastline",
    showbreak = "↳  ",
    listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
    autoread = true,
    autowrite = true,

    undofile = true,
    synmaxcol = 2500,
    formatoptions = "1jcroql",
    expandtab = true,
    autoindent = true,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 2,
    breakindentopt = "shift:2,min:20",
    wrap = false,
    linebreak = true,
    number = true,
    relativenumber = true,
    signcolumn = "yes",
    conceallevel = 0,
    concealcursor = "niv",
    colorcolumn = "100",

    numberwidth = 3,
    -- statuscolumn = "%=%{&nu && v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%s%C",

    -- Future column ui
    fillchars = [[fold: ,foldopen:,foldsep: ,foldclose:]],
    -- foldcolumn = "1",
    foldenable = false,
    foldlevel = 99,
    foldmethod = "indent",
    -- foldlevel = 99,
    -- statuscolumn = "%=%l%s%C",
    -- foldcolumn = "2",
    -- statuscolumn = "%=%l%s%C",
  }
  local function isempty(s)
    return s == nil or s == ""
  end

  -- custom python provider
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if not isempty(conda_prefix) then
    vim.g.python_host_prog = conda_prefix .. "/bin/python"
    vim.g.python3_host_prog = conda_prefix .. "/bin/python"
  elseif vim.loop.os_uname().sysname == "Darwin" then
    vim.g.python_host_prog = "/usr/bin/python"
    vim.g.python3_host_prog = "/usr/local/bin/python3"
  else
    vim.g.python_host_prog = "/usr/bin/python"
    vim.g.python3_host_prog = "/usr/bin/python3"
  end

  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
end

load_options()
