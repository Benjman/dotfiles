vim.cmd([[
    augroup lsp
        autocmd!
        autocmd FileType java :lua require('nv-lsp.config').start_jdt()
        autocmd FileType cpp :lua require('nv-lsp.clangd').setup()
    augroup END
]])
