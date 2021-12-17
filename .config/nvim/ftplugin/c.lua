require('cmp').setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').clangd.setup{
  capabilities = capabilities,
  on_attach = require('nv-lsp.common').on_attach,
}
