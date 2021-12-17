require('lspconfig').cmake.setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = require('nv-lsp.common').on_attach,
})
