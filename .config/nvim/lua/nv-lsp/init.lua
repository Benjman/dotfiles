vim.cmd([[
    augroup lsp
        autocmd! lsp
        autocmd FileType java :lua require('nv-lsp.jdt').start()
        autocmd FileType c,cpp,objc,objcpp,objective-c,objective-cpp,cuda,arduino,h,hpp :lua require('nv-lsp.clangd').start()
    augroup END
]])

