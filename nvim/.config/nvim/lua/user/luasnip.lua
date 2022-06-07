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
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local cpp = require "user.snippets.cpp"

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
  cpp = {
    snip({
      trig = "headerguard",
      namr = "Header guard",
    }, {
        func(cpp.header_guard, {}),
    }),
    snip({
      trig = "another",
      namr = "Another",
      dscr = "This is another snip",
    }, {
        func(function() return "// Hello from another snippet!" end, {}),
    }),
  },
})

