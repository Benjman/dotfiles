local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(
function(use)
    -- Buffer line
    use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }
    -- Theme
    use 'folke/tokyonight.nvim'
    -- Status line
    use { 'glepnir/galaxyline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
    -- Tab/Auto completion
    use 'hrsh7th/nvim-compe'
    -- Snippets
    use 'hrsh7th/vim-vsnip'
    -- Smooth scrolling
    use 'karb94/neoscroll.nvim'
    -- File explorer
    use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
    -- Provide git signs
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- Indent line
    use 'lukas-reineke/indent-blankline.nvim'
    -- Generic LSP
    use 'neovim/nvim-lspconfig'
    -- Java LSP
    use 'mfussenegger/nvim-jdtls'
    -- hex color
    use 'norcalli/nvim-colorizer.lua'
    -- Make finding stuff easier
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-fzy-native.nvim' } } }
    -- Nice highlighting
    use 'nvim-treesitter/nvim-treesitter'
    -- GLSL syntax highlighting
    use 'tikhomirov/vim-glsl'
    -- Float terminal
    use 'voldikss/vim-floaterm'
    -- Auto pairs '', "", [], {}, (), ``
    use { 'windwp/nvim-autopairs', requires = 'jiangmiao/auto-pairs' }
end
)
