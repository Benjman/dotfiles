local M = {}
local config = require('nv-lsp.config')
local util = require('nv-lsp.util')

function M.start()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true

    require('lspconfig').clangd.setup {
        capabilities = capabilities,
        filetypes = { 'arduino', 'c', 'cpp', 'cuda', 'h', 'hpp', 'objc', 'objcpp', 'objective-c', 'objective-cpp' },
        on_attach = config.on_attach,
        root_dir = require('lspconfig.util').root_pattern('compile_commands.json'),
    }

    vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})
    vim.g.completion_enable_snippet = 'snippets.nvim'
end

return M
