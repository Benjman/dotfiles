vim.cmd([[
    augroup lsp
        autocmd! lsp
        autocmd FileType java :lua require('nv-lsp.jdt').start()
        autocmd FileType cpp :lua require('nv-lsp.clangd')
        autocmd FileType cmake :lua require('lspconfig').cmake.setup{}
    augroup END
]])
