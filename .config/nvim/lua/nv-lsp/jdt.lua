local M = {}
local config = require('nv-lsp.config')
local jdtls = require('jdtls')
local lsp_diag = require('nv-lsp.diagnostics')
local lsp_ext = require('nv-lsp.ext')
local setup = require('jdtls.setup')
local util = require('nv-lsp.util')

local function mk_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.workspace.configuration = true
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        flags = {
            allow_incremental_sync = true,
        };
        handlers = {
--            ["textDocument/publishDiagnostics"] = lsp_diag.publishDiagnostics,
        };
        capabilities = capabilities;
        on_init = on_init;
        on_attach = on_attach;
    }
end

local function jdtls_on_attach(client, bufnr)
    on_attach(client, bufnr)
    local opts = { silent = true; }
    jdtls.setup_dap()
    jdtls.setup.add_commands()
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>df", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
end

function M.start()
    local root_dir = setup.find_root({'gradlew', '.git', 'mvnw', 'pom.xml'})
    local home = os.getenv('HOME')
    local workspace_folder = home .. "/.cache/jdt/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = mk_config()

    config.flags.server_side_fuzzy_completion = true
    config.settings = {
        java = {
            signatureHelp = { enabled = true };
            contentProvider = { preferred = 'fernflower' };
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            };
            sources = {
                organizeImports = {
                    starThreshold = 9999;
                    staticStarThreshold = 9999;
                };
            };
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                }
            };
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = '/usr/local/lib/java/jdk-11.0.12+7',
                    },
                }
            };
        };
    }
    config.cmd = {'jdtls', workspace_folder} -- cmd `jdtls` is an executable on the path, hopefull in ~/.local/bin
    config.on_attach = jdtls_on_attach

    local jar_patterns = {
        '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
        '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
        '/dev/microsoft/vscode-java-test/server/*.jar',
    }
    local bundles = {}
    for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
            if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
                table.insert(bundles, bundle)
            end
        end
    end
    local extendedClientCapabilities = jdtls.extendedClientCapabilities;
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
    config.init_options = {
        bundles = bundles;
        extendedClientCapabilities = extendedClientCapabilities;
    }
    jdtls.start_or_attach(config)
end

return M
