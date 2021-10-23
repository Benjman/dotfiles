local common = require('nv-lsp.common')

local key_mappings = {
    --{'definition', 'n', '<f5>',  '<cmd>echo "Hello"<cr>'},
}

local function on_attach(client, bufnr)
    common.on_attach(client, bufnr)
    common.map_keys(client, bufnr, key_mappings)
end

require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require('lspconfig').clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

