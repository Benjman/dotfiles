require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'glsl',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'python',
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    }
}

-- GLSL filetypes
vim.cmd([[
    augroup glsl
      au! glsl
      autocmd BufNewFile,BufRead *.vert,*.tesc,*.tese,*.geom,*.frag,*.comp, :set filetype=glsl
    augroup END
]])
