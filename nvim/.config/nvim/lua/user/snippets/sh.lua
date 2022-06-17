local func = require 'luasnip'.function_node
local snip = require 'luasnip'.snippet

return {
  snip({ trig = "#!", namr = "Bash Shebang", }, {
    func(function ()
      return "#!/bin/env /bin/bash"
    end, {}),
  }),
}
