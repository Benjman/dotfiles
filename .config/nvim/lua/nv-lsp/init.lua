vim.cmd([[
    augroup lsp
        autocmd! lsp
        autocmd FileType java :lua require('nv-lsp.jdt').start()
        autocmd FileType arduino,c,cpp,cuda,h,hpp,objc,objcpp,objective-c,objective-cpp :lua require('nv-lsp.clangd').start()
    augroup END
]])
