-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'catppuccin/nvim', as = 'catppuccin' }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use { 'mbbill/undotree' }

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  use { 'folke/lsp-colors.nvim', event = 'BufRead', }

  use {
	  'simrat39/symbols-outline.nvim',
	  config = function()
		  require('symbols-outline').setup()
	  end
  }

  use {
	  'folke/trouble.nvim',
	  cmd = 'TroubleToggle',
  }

  use { 'RRethy/vim-illuminate' }
  use { 'LunarVim/peek.lua' }
  use { 'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

end)
