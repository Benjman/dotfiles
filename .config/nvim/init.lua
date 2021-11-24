require 'keybindings'
require 'plugins'
require 'settings'
require 'utils'

-- Minimal configuration plugins:
require 'nv-theme'          -- make theme pretty
require 'nv-treesitter'     -- make syntax pretty
require 'nv-nvimtree'       -- file navigation
require 'nv-lsp'            -- language servers

-- Fluff plugins:
require 'nv-cmp'            -- tab completion
require 'nv-colorizer'      -- bg colorizing of hex, rgb, hsl, etc.
require 'nv-autopairs'      -- auto pairs '', "", [], {}, (), ``
require 'nv-gitsigns'       -- line level change indicators
require 'nv-vsnip'          -- snippets
require 'nv-neoscroll'      -- smooth scrolling
require 'nv-telescope'      -- Fuzzy finders
