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

-- array of mappings to setup; {<capability_name>, <mode>, <lhs>, <rhs>}
local key_mappings = {
    {"code_action", "n", "<a-CR>", "<Cmd>lua require('jdtls').code_action()<CR>"},
    {"code_action", "n", "<leader>r", "<Cmd>lua require('jdtls'.code_action(false, 'refactor'))<CR>"},
    {"code_action", "v", "<a-CR>", "<Esc><Cmd>lua require('jdtls').code_action(true)<CR>"},
    {"code_action", "v", "<leader>r", "<Esc><Cmd>lua require('jdtls').code_action(true, 'refactor')<CR>"},

    {"document_formatting", "n", "gq", "<Cmd>lua vim.lsp.buf.formatting()<CR>"},
    {"document_range_formatting", "v", "gq", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>"},
    {"find_references", "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>"},
    {"hover", "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>"},
    {"implementation", "n", "gD",  "<Cmd>lua vim.lsp.buf.implementation()<CR>"},
    {"signature_help", "i", "<c-space>",  "<Cmd>lua vim.lsp.buf.signature_help()<CR>"},
    {"workspace_symbol", "n", "gW", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"}
}

local function on_init(client)
    lsp_ext.setup()
    if client.config.settings then
        client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
end

function M.on_attach(client, bufnr)
    lsp_ext.attach(client, bufnr)
    vim.api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "bufhidden", "hide")
    vim.api.nvim_command("setlocal signcolumn=yes")

    if client.resolved_capabilities.goto_definition then
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', "v:lua.lsp_ext.tagfunc")
    end
    local opts = { silent = true; }
    for _, mappings in pairs(key_mappings) do
        local capability, mode, lhs, rhs = unpack(mappings)
        if client.resolved_capabilities[capability] then
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
    end
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "crr", "<Cmd>lua vim.lsp.buf.rename(vim.fn.input('New Name: '))<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]w", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[w", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<c-n>", "<Cmd>lua require('lsp-ext').trigger_completion()<CR>", opts)
    if client.resolved_capabilities['document_highlight'] then
        vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end
end

function M.add_client(cmd, opts)
    local config = mk_config()
    config['name'] = opts and opts.name or cmd[1]
    config['cmd'] = cmd
    add_client_by_cfg(config, opts and opts.root or {'.git'})
end

return M
