local common = require('nv-lsp.common')
local jdtls = require('jdtls')
local lsp_ext = require('nv-lsp.ext')
local util = require('nv-lsp.util')

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
  --map('n', '<f3>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  --map('n', '<A-o>', '<Cmd>lua require\'jdtls\'.organize_imports()<CR>', opts)
  --map('n', '<leader>df', '<Cmd>lua require\'jdtls\'.test_class()<CR>', opts)
  --map('n', '<leader>dn', '<Cmd>lua require\'jdtls\'.test_nearest_method()<CR>', opts)
  --map('v', 'crv', '<Esc><Cmd>lua require(\'jdtls\').extract_variable(true)<CR>', opts)
  --map('n', 'crv', '<Cmd>lua require(\'jdtls\').extract_variable()<CR>', opts)
  --map('v', 'crm', '<Esc><Cmd>lua require(\'jdtls\').extract_method(true)<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "crr", "<Cmd>lua vim.lsp.buf.rename(vim.fn.input('New Name: '))<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "]w", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "[w", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "i", "<c-n>", "<Cmd>lua require('lsp-ext').trigger_completion()<CR>", opts)
}

local function on_init(client)
  lsp_ext.setup()
  if client.config.settings then
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end

local function mk_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    flags = {
      allow_incremental_sync = true,
    };
    handlers = {
      -- ["textDocument/publishDiagnostics"] = lsp_diag.publishDiagnostics,
    };
    capabilities = capabilities;
    on_init = on_init;
  }
end

local function jdtls_on_attach(client, bufnr)
  lsp_ext.attach(client, bufnr)
  vim.api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "hide")
  vim.api.nvim_command("setlocal signcolumn=yes")

  if client.resolved_capabilities.goto_definition then
    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', "v:lua.lsp_ext.tagfunc")
  end

  common.on_attach(client, bufnr)
  common.map_keys(client, bufnr, key_mappings)

  --jdtls.setup_dap() -- TODO setup dap https://github.com/mfussenegger/nvim-jdtls#debugger-via-nvim-dap
  jdtls.setup.add_commands()

  if client.resolved_capabilities['document_highlight'] then
    vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
  end

  vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})
  vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
  vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
  vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})
end

local root_dir = util.find_root({'gradlew', '.git', 'mvnw', 'pom.xml'})
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
