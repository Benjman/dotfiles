local M = {}
local common = require('nv-lsp.common')
local lsp = require('lspconfig')

local key_mappings = {
    {'definition', 'n', '<f5>',  '<cmd>echo "Hello"<cr>'},
}

local function on_attach(client, bufnr)
    common.on_attach(client, bufnr)
    --common.map_keys(client, bufnr, key_mappings)
end

function M.start()
    require('lspconfig').clangd.setup({
        cmd = {'clangd', '--background-index'},
        on_attach = on_attach
    })
end

return M
