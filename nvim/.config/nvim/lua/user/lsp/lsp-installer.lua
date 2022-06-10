local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local handlers = require 'user.lsp.handlers'

local servers = {
  "bashls",
  "clangd",
  "cmake",
  "sumneko_lua",
  "yamlls",
}

local settings = {
  ensure_installed = servers,
  ui = {
    icons = require "user.icons".lsp_installer,
    keymaps = require "user.keymaps".lsp_installer,
  },

  log_level = vim.log.levels.INFO,
  -- max_concurrent_installers = 4,
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  -- if server == "bashls" then
  --   print("Hit")
  -- end

  if server == "clangd" then
    local clangd_opts = require "user.lsp.settings.clangd"
    opts = vim.tbl_deep_extend("keep", clangd_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  lspconfig[server].setup(opts)
end
