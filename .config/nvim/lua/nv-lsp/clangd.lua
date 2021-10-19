local M = {}

local function on_attach(client)
    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    --local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    --local opts = { noremap = true, silent = true }
    --map('n', '<f3>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    --map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    --map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    --map('n', '<leader>go', '<cmd>lua require(\'nv-lsp.clangd\').outline()<cr>', opts)
    --map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    --map('n', '<c-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    --map('n', '<a-T>', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    --map('i', '<c-space>', '<Cmd>lua vim.lsp.buf.completion()<CR>', opts)

    if client.resolved_capabilities['document_highlight'] then
        vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end
end

function M.start()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true

    require('lspconfig').clangd.setup({
        capabilities = capabilities,
        filetypes = { 'arduino', 'c', 'cpp', 'cuda', 'h', 'hpp', 'objc', 'objcpp', 'objective-c', 'objective-cpp' },
        on_attach = on_attach,
        root_dir = require('lspconfig.util').root_pattern({'compile_commands.json', '.git'}),
    })

    vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})
    vim.g.completion_enable_snippet = 'snippets.nvim'
end

return M
