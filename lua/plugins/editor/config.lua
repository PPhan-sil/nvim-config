local Icons = require("icons")

local config = {}

function config.illuminate()
  require("illuminate").configure({
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 100,
    filetypes_denylist = {
      "alpha",
      "dashboard",
      "DoomInfo",
      "fugitive",
      "help",
      "norg",
      "NvimTree",
      "Outline",
      "packer",
      "toggleterm",
    },
    under_cursor = false,
  })
end

function config.autopairs()
  require("nvim-autopairs").setup({})

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  local handlers = require("nvim-autopairs.completion.handlers")
  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
      filetypes = {
        -- "*" is an alias to all filetypes
        ["*"] = {
          ["("] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method,
            },
            handler = handlers["*"],
          },
        },
        -- Disable for tex
        tex = false,
      },
    })
  )
end

function config.treesitter()
  vim.api.nvim_set_option_value("foldmethod", "manual", {})
  vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "html",
      "java",
      "javascript",
      "json",
      "latex",
      "lua",
      "make",
      "python",
      "rust",
      "typescript",
      "yaml",
    },
    highlight = {
      enable = true,
      disable = { "vim" },
      additional_vim_regex_highlighting = false,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]["] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_next_end = {
          ["]]"] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
    },
    context_commentstring = { enable = true, enable_autocmd = false },
  })
  require("nvim-treesitter.install").prefer_git = true
end

function config.autotag()
  require("nvim-ts-autotag").setup({
    filetypes = {
      "html",
      "xml",
      "javascript",
      "typescriptreact",
      "javascriptreact",
      "vue",
      "astro",
    },
  })
end

function config.neoscroll()
  require("neoscroll").setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
    },
    hide_cursor = false, -- Hide cursor while scrolling
    stop_eof = true, -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = "sine", -- Default easing function
    pre_hook = nil, -- Function to run before the scrolling animation starts
    post_hook = nil, -- Function to run after the scrolling animation ends
  })
end

function config.toggleterm()
  require("toggleterm").setup({
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.40
      end
    end,
    on_open = function()
      -- Prevent infinite calls from freezing neovim.
      -- Only set these options specific to this terminal buffer.
      vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
      vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
    end,
    open_mapping = false, -- [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
  })
end

function config.zen()
  require("zen-mode").setup({
    window = {
      backdrop = 1,
      height = 0.95,
      options = {
        signcolumn = "yes",
      },
    },
    plugins = {
      gitsigns = { enabled = true },
    },
  })
end

function config.colorizer()
  require("colorizer").setup({
    filetypes = {
      "css",
      "html",
    },
  })
end

function config.autoSession()
  local opts = {
    log_level = "info",
    auto_session_enable_last_session = true,
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_suppress_dirs = nil,
  }

  require("auto-session").setup(opts)
end

function config.betterEscape()
  require("better_escape").setup({
    mapping = { "jk", "jj" }, -- a table with mappings to use
    timeout = 500, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
  })
end

function config.dap()
  local icons = { dap = Icons.get("dap") }

  local dap = require("dap")
  local dapui = require("dapui")

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.after.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.after.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
  vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ABE9B3" })

  vim.fn.sign_define(
    "DapBreakpoint",
    { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
  )
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
  )
  vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
  vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
  )
  vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},

      runInTerminal = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  dap.adapters.go = function(callback)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = { nil, stdout },
      args = { "dap", "-l", "127.0.0.1:" .. port },
      detached = true,
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        vim.notify(
          string.format('"dlv" exited with code: %d, please check your configs for correctness.', code),
          vim.log.levels.WARN,
          { title = "[go] DAP Warning!" }
        )
      end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(function()
      callback({ type = "server", host = "127.0.0.1", port = port })
    end, 100)
  end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    { type = "go", name = "Debug", request = "launch", program = "${file}" },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}",
    }, -- works with go.mod packages and sub packages
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }

  dap.adapters.python = {
    type = "executable",
    command = "/usr/bin/python",
    args = { "-m", "debugpy.adapter" },
  }
  dap.configurations.python = {
    {
      -- The first three options are required by nvim-dap
      type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch",
      name = "Launch file",
      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = function()
        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python"
        end
      end,
    },
  }
end

function config.dapUI()
  local icons = {
    ui = Icons.get("ui"),
    dap = Icons.get("dap"),
  }

  require("dapui").setup({
    icons = { expanded = icons.ui.ArrowOpen, collapsed = icons.ui.ArrowClosed, current_frame = icons.ui.Indicator },
    mappings = {
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
    },
    layouts = {
      {
        elements = {
          {
            id = "scopes",
            size = 0.25, -- Can be float or integer > 1
          },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 40,
        position = "left",
      },
      { elements = { "repl" }, size = 10, position = "bottom" },
    },
    -- Requires Nvim version >= 0.8
    controls = {
      enabled = true,
      -- Display controls in this session
      element = "repl",
      icons = {
        pause = icons.dap.Pause,
        play = icons.dap.Play,
        step_into = icons.dap.StepInto,
        step_over = icons.dap.StepOver,
        step_out = icons.dap.StepOut,
        step_back = icons.dap.StepBack,
        run_last = icons.dap.RunLast,
        terminate = icons.dap.Terminate,
      },
    },
    floating = {
      max_height = nil,
      max_width = nil,
      mappings = { close = { "q", "<Esc>" } },
    },
    windows = { indent = 1 },
  })
end

function config.ufo()
  require("ufo").setup({
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  })
end

return config
