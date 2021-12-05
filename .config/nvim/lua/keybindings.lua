local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {noremap = true, silent = true}

-- Disbale 'Space' key
map('n', '<Space>', '', opt)

-- Set 'Space' key as leader key
vim.g.mapleader = ' '

-- Disable arrow keys
map('',  '<Up>',    '', opt)
map('i', '<Up>',    '', opt)
map('',  '<Down>',  '', opt)
map('i', '<Down>',  '', opt)
map('',  '<Left>',  '', opt)
map('i', '<Left>',  '', opt)
map('',  '<Right>', '', opt)
map('i', '<Right>', '', opt)

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv', opt)
map('x', 'J', ':move \'>+1<CR>gv-gv', opt)

-- Move between windows
map('n', '<C-h>', '<C-w>h', opt)
map('n', '<C-j>', '<C-w>j', opt)
map('n', '<C-k>', '<C-w>k', opt)
map('n', '<C-l>', '<C-w>l', opt)

-- Move viewport while in insert mode
map('i', '<C-K>', '<esc><c-y>a')
map('i', '<C-J>', '<esc><c-e>a')

-- Resize windows
map('n', '<C-A-k>', '<C-w>5+', opt)
map('n', '<C-A-j>', '<C-w>5-', opt)
map('n', '<C-A-h>', '<C-w>5<', opt)
map('n', '<C-A-l>', '<C-w>5>', opt)

-- Use Tab and Shift-Tab to move block of text in visual mode
map('v', '<TAB>', '>gv', opt)
map('v', '<S-TAB>', '<gv', opt)

-- LSP stuff
map('n', '<leader>ls', '<cmd>LspStart<cr>', opt)
map('n', '<leader>lS', '<cmd>LspStop<cr>', opt)
map('n', '<leader>lr', '<cmd>LspRestart<cr>', opt)

-- escape terminal-mode
map('t', '<Esc>', '<C-\\><C-n>', opt)
map('t', '<C-h>', '<C-\\><C-n> <C-h>', opt)
map('t', '<C-j>', '<C-\\><C-n> <C-j>', opt)
map('t', '<C-k>', '<C-\\><C-n> <C-k>', opt)
map('t', '<C-l>', '<C-\\><C-n> <C-l>', opt)

-- Spelling
map('n', '<leader>sn', ']s',  opt)  -- next misspell
map('n', '<leader>sp', '[s',  opt)  -- previous misspell
map('n', '<leader>sa', 'zg',  opt)  -- add word to spellfile
map('n', '<leader>sr', 'zug', opt)  -- remove word to spellfile
