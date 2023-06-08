local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'tpope/vim-commentary'
  use 'wbthomason/packer.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use "williamboman/mason.nvim"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason-lspconfig.nvim"
  use "glepnir/lspsaga.nvim"
  use { "nvim-telescope/telescope.nvim", tag = '0.1.0', dependencies = {{'nvim-lua/plenary.nvim'}}}
  use 'lewis6991/gitsigns.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-lualine/lualine.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
  -- 
  
  -- 'bluz71/vim-nightfly-colors',
  -- 'vim-test/vim-test',
  
  -- 'preservim/vimux',
  -- 'tpope/vim-fugitive',
  

  -- rust
  -- 'mfussenegger/nvim-dap',
  -- 'rcarriga/nvim-dap-ui',
  -- 'simrat39/rust-tools.nvim',

  -- completion
	  -- 
	  -- 
  -- }
