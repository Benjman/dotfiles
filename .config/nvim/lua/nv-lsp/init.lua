vim.cmd([[
	augroup lsp
        autocmd!
		autocmd FileType java :lua require('nv-lsp.config').start_jdt()
	augroup END
]])

