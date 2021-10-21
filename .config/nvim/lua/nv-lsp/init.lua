vim.cmd([[
    augroup lsp
        autocmd! lsp
        autocmd FileType java :lua require('nv-lsp.jdt').start()
        autocmd FileType cpp :lua require'lspconfig'.clangd.setup{}
    augroup END
]])
