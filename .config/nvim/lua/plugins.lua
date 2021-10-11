local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(
function(use)
    -- Theme
    use 'folke/tokyonight.nvim'
    -- Status line
    use { 'glepnir/galaxyline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
    -- For hex color
    use 'norcalli/nvim-colorizer.lua'
    -- File explorer
    use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
    -- For indent line
    use 'lukas-reineke/indent-blankline.nvim'
    -- Float terminal
    use 'voldikss/vim-floaterm'
    -- Buffer line
    use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }
    -- Make finding stuff easier
    use { 'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzy-native.nvim' }
        }
    }
    -- Neovim LSP
    use 'neovim/nvim-lspconfig'
    -- Java LSP
    --use 'mfussenegger/nvim-jdtls'
    -- Tab/Auto completion
    use 'hrsh7th/nvim-compe'
    -- Auto pairs '', "", [], {}, (), ``
    use 'jiangmiao/auto-pairs'
    use 'windwp/nvim-autopairs'
    -- For nice highlighting
    use 'nvim-treesitter/nvim-treesitter'
    -- For snippets
    use 'hrsh7th/vim-vsnip'
    -- Provide git signs
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- Debugging
    --use { 'puremourning/vimspector' } -- TODO
    -- Smooth scrolling
    use 'karb94/neoscroll.nvim'
	-- GLSL syntax highlighting
	use 'tikhomirov/vim-glsl'
end
)

