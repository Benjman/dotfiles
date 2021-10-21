local M = {}

    --map('n', '<f3>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    --map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    --map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    --map('n', '<leader>go', '<cmd>lua require(\'nv-lsp.clangd\').outline()<cr>', opts)
    --map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    --map('n', '<c-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    --map('n', '<a-T>', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    --map('i', '<c-space>', '<Cmd>lua vim.lsp.buf.completion()<CR>', opts)

local key_mappings = {
    {'document_formatting', 'n', 'gq', '<Cmd>lua vim.lsp.buf.formatting()<CR>'},
    {'document_range_formatting', 'v', 'gq', '<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>'},
    {'find_references', 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>'},
    {'hover', 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>'},
    {'implementation', 'n', 'gD',  '<Cmd>lua vim.lsp.buf.implementation()<CR>'},
    {'signature_help', 'i', '<c-space>',  '<Cmd>lua vim.lsp.buf.signature_help()<CR>'},
    {'workspace_symbol', 'n', 'gW', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>'},
    --map('n', '<f3>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'crr', '<Cmd>lua vim.lsp.buf.rename(vim.fn.input('New Name: '))<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', ']w', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '[w', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-n>', '<Cmd>lua require('lsp-ext').trigger_completion()<CR>', opts)
}

--[[
Key map table items in this structure:
    {capability, mode, keys, command}
    
    Example:
        key_maps = {
            {'find_references', 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>'}
        }
--]]
function M.map_keys(client, bufnr, key_maps)
    local opts = { noremap = true, silent = true }
    for _, mappings in pairs(key_maps) do
        local capability, mode, lhs, rhs = unpack(mappings)
        if client.resolved_capabilities[capability] then
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
    end
end

function M.on_attach(client, bufnr)
    if client.resolved_capabilities['document_highlight'] then
        vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end

    vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
    vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})

    M.map_keys(client, bufnr, key_mappings)
end

return M
