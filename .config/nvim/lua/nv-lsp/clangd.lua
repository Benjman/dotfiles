local M = {}
local util = require('nv-lsp.util')
local pickers = require("telescope.pickers")

function M.outline()
    -- TODO outline fuzzy finder. See https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#picker
    -- See https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#picker
    -- Primeagen implementation https://github.com/ThePrimeagen/.dotfiles/blob/9990fea97c007d4c1f51481dd54cc74fcfc5e21d/nvim/.config/nvim/lua/theprimeagen/telescope.lua#L175
    pickers.new({
        prompt_title = "Test"
    }):find()
end

local function on_attach(client)
    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    map('n', '<f3>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    map('n', '<leader>go', '<cmd>lua require(\'nv-lsp.clangd\').outline()<cr>', opts)
    map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    map('n', '<c-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    map('n', '<a-T>', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    map('i', '<c-space>', '<Cmd>lua vim.lsp.buf.completion()<CR>', opts)
end

function M.start()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true

    require('lspconfig').clangd.setup {
        capabilities = capabilities,
        filetypes = { 'arduino', 'c', 'cpp', 'cuda', 'h', 'hpp', 'objc', 'objcpp', 'objective-c', 'objective-cpp' },
        on_attach = on_attach,
        root_dir = require('lspconfig.util').root_pattern('compile_commands.json'),
    }

    vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})
    vim.g.completion_enable_snippet = 'snippets.nvim'

    -- highlight symbol under the cursor
    vim.cmd [[
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
    ]]

end

return M
