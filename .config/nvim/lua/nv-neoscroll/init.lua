local neoscroll = require('neoscroll')

neoscroll.setup({
    -- All these keys will be mapped. Pass an empty table ({}) for no mappings
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
})


local opt = {silent = true, noremap = true}
local map = vim.api.nvim_set_keymap

map('n', '<C-u>', '<cmd>lua require(\'neoscroll\').scroll(-vim.wo.scroll, true, 200)<cr>', opt)
map('n', '<C-d>', '<cmd>lua require(\'neoscroll\').scroll( vim.wo.scroll, true, 200)<cr>', opt)
map('n', '<C-b>', '<cmd>lua require(\'neoscroll\').scroll(-vim.api.nvim_win_get_height(0), true, 300)<cr>', opt)
map('n', '<C-f>', '<cmd>lua require(\'neoscroll\').scroll( vim.api.nvim_win_get_height(0), true, 300)<cr>', opt)
map('n', '<C-y>', '<cmd>lua require(\'neoscroll\').scroll(-0.10, false, 100)<cr>', opt)
map('n', '<C-e>', '<cmd>lua require(\'neoscroll\').scroll( 0.10, false, 100)<cr>', opt)
map('n', 'zt', '<cmd>lua require(\'neoscroll\').zt(200)<cr>', opt)
map('n', 'zz', '<cmd>lua require(\'neoscroll\').zz(200)<cr>', opt)
map('n', 'zb', '<cmd>lua require(\'neoscroll\').zb(200)<cr>', opt)
