local func = require 'luasnip'.function_node
local snip = require 'luasnip'.snippet

return {
  snip({ trig = "headerguard", namr = "Header guard", }, {
    func(function ()
      return "// TODO implememt header guard snippet"
    end, {}),
  }),
}
