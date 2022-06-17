-- require("luasnip/loaders/from_vscode").lazy_load({
--   paths = {
--     vim.fn.stdpath('config') .. "/snippets/cpp.json",
--   }
-- })

local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

local snip = ls.snippet
local snippets = require "user.snippets"
local func = ls.function_node

vim.keymap.set({ "i", "s" }, "<C-k>", ls.expand_or_jump, { silent = true })

ls.config.set_config {
  history = true,
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 200,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = false,
  store_selection_keys = "<c-s>",
}

ls.add_snippets(nil, {
  cpp = snippets.cpp,
  sh = snippets.sh
  -- sh = {
  --   snip(snippets.sh.shebang),
  -- },
})

-- snip({
--   trig = "headerguard",
--   namr = "Header guard",
-- }, {
--     func(cpp.header_guard, {}),
-- }),
