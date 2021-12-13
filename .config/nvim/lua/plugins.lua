local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(
function(use)
  -- -------------------------
  --     MINIMAL CONFIG     --
  -- =========================

  -- theme
  use {
    'folke/tokyonight.nvim',
    config = require('nv-theme'),
  }

  -- syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    config = require('nv-treesitter'),
  }

  -- file navigation
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('nv-nvimtree'),
  }

  -- language server
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'mfussenegger/nvim-jdtls',
      'ray-x/lsp_signature.nvim',
    },
    config = require('nv-lsp'),
  }


  -- ----------------------
  --     FLUFF BELOW     --
  -- ======================

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/vim-vsnip',
    },
    config = require('nv-cmp'),
  }

  -- pairs '', "", [], {}, (), ``
  use {
    'windwp/nvim-autopairs',
    requires = 'jiangmiao/auto-pairs',
    config = require('nvim-autopairs').setup(),
  }

  -- sweet commenting actions
  use {
    'numToStr/Comment.nvim',
    config = require('nv-comment'),
  }

  -- show when lines have been modified from repo
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = require('nv-gitsigns'),
  }

  -- smooth scrolling
  use {
    'karb94/neoscroll.nvim',
    config = require('nv-neoscroll'),
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
    },
    config = require('nv-telescope'),
  }

  -- git integration
  use {
    'tpope/vim-fugitive',
  }

  -- hex colorizer
  use {
    'norcalli/nvim-colorizer.lua',
    config = require('nv-colorizer'),
  }

end
)
