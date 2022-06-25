local func = require 'luasnip'.function_node
local snip = require 'luasnip'.snippet

return {
  snip({ trig = "#!", namr = "Bash Shebang", }, {
    func(function ()
      return "#!/usr/bin/sh"
    end, {}),
  }),
}
