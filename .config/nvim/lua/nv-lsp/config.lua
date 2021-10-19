local M = {}
local jdtls = require('jdtls')
local lsp_diag = require('nv-lsp.diagnostics')
local lsp_ext = require('nv-lsp.ext')
local setup = require('jdtls.setup')
local util = require('nv-lsp.util')
local lsps = {}

local function add_client_by_cfg(config, root_markers)
    local root_dir = setup.find_root(root_markers)
    if not root_dir then return end

    local cmd = config.cmd[1]
    if tonumber(vim.fn.executable(cmd)) == 0 then
        vim.api.nvim_command(string.format(
        ':echohl WarningMsg | redraw | echo "No LSP executable: %s" | echohl None', cmd))
        return
    end
    config['root_dir'] = root_dir
    local lsp_id = tostring(vim.bo.filetype) .. '│' .. root_dir
    local client_id = lsps[lsp_id]
    if not client_id then
        client_id = vim.lsp.start_client(config)
        lsps[lsp_id] = client_id
    end
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.buf_attach_client(bufnr, client_id)
end

function M.add_client(cmd, opts)
    local config = mk_config()
    config['name'] = opts and opts.name or cmd[1]
    config['cmd'] = cmd
    add_client_by_cfg(config, opts and opts.root or {'.git'})
end

return M
