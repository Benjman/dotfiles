local on_attach = function(client, bufnr)
    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    map('n', '<f3>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    map('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    map('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    map('n', '<c-space>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
    map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
    map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
    map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    map('n', 'rr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    map('n', '<leader>x', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
    map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
    map('n', '<leader>xx', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
        map('n', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)
    end
end

vim.g.completion_enable_snippet = 'snippets.nvim'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconf = require 'lspconfig'
local servers = { 'clangd' }

-- Load language servers
for _, lang in ipairs(servers) do
    lspconf[lang].setup {
        on_attach = on_attach,
        root_dir = vim.loop.cwd,
        capabilities = capabilities
    }
end


vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})

