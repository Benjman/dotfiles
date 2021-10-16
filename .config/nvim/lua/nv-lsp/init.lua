vim.cmd([[
    augroup lsp
        autocmd! lsp
        autocmd FileType java :lua require('nv-lsp.config').start_jdt()
        autocmd FileType c,cpp,objc,objcpp,objective-c,objective-cpp,cuda,arduino :lua require('nv-lsp.config').start_clangd()
    augroup END
]])

