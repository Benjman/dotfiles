local M = {}

local key_mappings = {
    {'code_action', 'n', '<c-space>', '<cmd>lua vim.lsp.buf.code_action()<cr>'},
    {'goto_definition', 'n', '<f3>', '<cmd>lua vim.lsp.buf.definition()<cr>'},
    {'goto_definition', 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>'},
    {'goto_definition', 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>'},
    {'find_references', 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>'},
    {'implementation', 'n', 'gi',  '<Cmd>lua vim.lsp.buf.implementation()<CR>'},
    {'signature_help', 'i', '<c-space>',  '<Cmd>lua vim.lsp.buf.signature_help()<CR>'},
    {'rename', 'n', '<leader>rr',  '<cmd>lua vim.lsp.buf.rename()<cr>'},

    --vim.api.nvim_buf_set_keymap(bufnr, 'n', ']w', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '[w', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
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
        if capability == '' or client.resolved_capabilities[capability] then
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
