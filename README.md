# My Neovim Configuration

This repository contains my personal Neovim configuration. Neovim is a highly customizable text editor, and this configuration reflects my preferences and workflow. Feel free to explore and use it as a starting point for your own setup.

## Installation

To use this configuration:

1. Make sure you have Neovim installed on your system.
2. Clone this repository to your Neovim configuration directory:

```bash
git clone https://github.com/PPhan-sil/nvim-config.git ~/.config/nvim --depth 1
```

3. Launch Neovim (`nvim`). It will automatically install the plugins with LazyVim. Restart Neovim for all changes to apply. Some plugins may require additional system dependencies to run properly

## File Structure
```
./config/nvim
└───init.lua
│   
└───lua
    │
    └───config
    │   └───init.lua
    │   └───options.lua
    │   └───keymaps.lua
    │   └───autocmds.lua
    │
    └───plugins
        └───editor
        │   └───init.lua
        │   └───config.lua
        └───coding
        │   └───init.lua
        │   └───config.lua
        └───tools
        │   └───init.lua
        │   └───config.lua
        └───ui
        │   └───init.lua
        │   └───config.lua
        └───lsp
            └───init.lua
            └───config.lua
            └───format.lua
            └───keymaps.lua
```

## Plugins

### Plugin Manager
- [lazy.nvim](https://github.com/folke/lazy.nvim)

### Editor
<details>
  <summary>Editor plugins</summary>
  
  - [auto-session](https://github.com/rmagatti/auto-session)
  - [better-escape.nvim](https://github.com/max397574/better-escape.nvim)
  - [Comment.nvim](https://github.com/numToStr/Comment.nvim)
  - [diffview.nvim](https://github.com/sindrets/diffview.nvim)
  - [document-color.nvim](https://github.com/mrshmllow/document-color.nvim)
  - [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)
  - [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
  - [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua)
  - [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  - [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  - [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)
  - [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
  - [nvim-ts-hint-texttobject](https://github.com/mfussenegger/nvim-treehopper)
  - [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
  - [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
  - [promise-async.nvim](https://github.com/kevinhwang91/promise-async)
  - [statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim)
  - [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
  - [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
  - [vim-illuminate](https://github.com/RRethy/vim-illuminate)
  - [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)
</details>

### UI
<details>
  <summary>UI plugins</summary>
  
- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [fidget.nvim](https://github.com/j-hui/fidget.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [neodim](https://github.com/zbirenbaum/neodim)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-scrollview](https://github.com/dstein64/nvim-scrollview)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
  
Colorschemes
- [catppuccin](https://github.com/catppuccin/nvim)
- [edge](https://github.com/sainnhe/edge)
- [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
- [nord.nvim](https://github.com/shaunsingh/nord.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
</details>


### Tools
<details>
  <summary>Additional tools</summary>
  
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [project.nvim](https://github.com/ahmedkhalf/project.nvim)
- [sniprun](https://github.com/michaelb/sniprun)
- [sqlite ](https://github.com/kkharji/sqlite.lua)
- [telescope-frequency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim)
- [telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
- [telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [vimtex](https://github.com/lervag/vimtex)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
</details>

### LSP
<details>
  <summary>LSP plugins</summary>
  
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-latex-symbols](https://github.com/kdheepak/cmp-latex-symbols)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp-spell](https://github.com/f3fora/cmp-spell)
- [cmp-under-comparator](https://github.com/lukas-reineke/cmp-under-comparator)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [lsp_signature](https://github.com/ray-x/lsp_signature.nvim)
- [lspkind.nvim](https://github.com/onsails/lspkind.nvim)
- [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
</details>
