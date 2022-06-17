local status_ok, _ = pcall(require, "colorizer")
if not status_ok then
  return
end

local filetypes = {

  "cpp",
  "css",
  "xdefaults",
  "yaml",

}

require 'colorizer'.setup (filetypes, {
  RGB      = true,         -- #RGB hex codes
  RRGGBB   = true,         -- #RRGGBB hex codes
  names    = true,         -- "Name" codes like Blue
  RRGGBBAA = false,        -- #RRGGBBAA hex codes
  rgb_fn   = true,        -- CSS rgb() and rgba() functions
  hsl_fn   = true,        -- CSS hsl() and hsla() functions
  css      = true,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn   = true,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
  -- Available modes: foreground, background
  mode     = 'background', -- Set the display mode.
})
