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

    use 'folke/tokyonight.nvim'                     -- make theme pretty
    use 'nvim-treesitter/nvim-treesitter'           -- make syntax pretty
    use { 'kyazdani42/nvim-tree.lua',               -- file navigation
        requires = 'kyazdani42/nvim-web-devicons' }
    use 'neovim/nvim-lspconfig'                     -- language servers


    -- ----------------------
    --     FLUFF BELOW     --
    -- ======================

    use { 'hrsh7th/nvim-cmp',                       -- advanced completion beyond omnifunc
        requires = { 
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' } } }
    use 'hrsh7th/vim-vsnip'               -- snippet support
    use { 'windwp/nvim-autopairs',                  -- pairs '', "", [], {}, (), ``
        requires = 'jiangmiao/auto-pairs' }
    use { 'lewis6991/gitsigns.nvim',                -- show when lines have been modified from repo
        requires = 'nvim-lua/plenary.nvim' }
    use 'karb94/neoscroll.nvim'                     -- better scrolling experience (like <c-u> & <c-d>)
    use { 'nvim-telescope/telescope.nvim',          -- fuzzy finder
        requires = { { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzy-native.nvim' } } }

    ---- Java LSP
    --use 'mfussenegger/nvim-jdtls'
    ---- GLSL syntax highlighting
    --use 'tikhomirov/vim-glsl'
end
)
