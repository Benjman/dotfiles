vim.cmd([[
augroup lsp
autocmd! lsp
autocmd FileType cmake :lua require('lspconfig').cmake.setup()
autocmd FileType cpp :lua require('nv-lsp.clangd')
autocmd FileType java :lua require('nv-lsp.jdt').start()
autocmd FileType lua :lua require('nv-lsp.lua')
augroup END
]])
