require'nvim-tree'.setup {
  filters = {
    custom = { '.git', '.gitignore', '.gitmodules', 'node_modules', '.cache' },
    dotfiles = true
  },
  view = {
    -- if true the tree will resize itself after opening a file
    auto_resize = true,
  },
}

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_window_picker_exclude = {
  filetype = {
    'notify',
    'packer',
    'qf'
  },
  buftype = {
    'terminal'
  }
}

vim.g.nvim_tree_group_empty = 0 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    untracked = '★',
    deleted = '',
    ignored = '◌'
  },
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  }
}
vim.g.nvim_tree_refresh_wait = 500 --1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
vim.g.nvim_tree_special_files = {}

-- Mappings for nvimtree
vim.api.nvim_set_keymap('n', '`', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '~', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- key can be either a string or a table of string (lhs)
-- cb is the callback that will be called
-- mode is normal by default
local tree_cb = require('nvim-tree.config').nvim_tree_callback
-- default mappings
local list = {
  { key = {'<CR>', 'o'},                  cb = tree_cb('edit') },
  { key = '<C-]>',                        cb = tree_cb('cd') },
  { key = '<C-v>',                        cb = tree_cb('vsplit') },
  { key = '<C-x>',                        cb = tree_cb('split') },
  { key = '<C-t>',                        cb = tree_cb('tabnew') },
  { key = '<',                            cb = tree_cb('prev_sibling') },
  { key = '>',                            cb = tree_cb('next_sibling') },
  { key = 'P',                            cb = tree_cb('parent_node') },
  { key = 'x',                            cb = tree_cb('close_node') },
  { key = '<Tab>',                        cb = tree_cb('preview') },
  { key = 'K',                            cb = tree_cb('first_sibling') },
  { key = 'J',                            cb = tree_cb('last_sibling') },
  { key = 'I',                            cb = tree_cb('toggle_ignored') },
  { key = 'H',                            cb = tree_cb('toggle_dotfiles') },
  { key = 'R',                            cb = tree_cb('refresh') },
  { key = 'a',                            cb = tree_cb('create') },
  { key = 'd',                            cb = tree_cb('remove') },
  { key = 'r',                            cb = tree_cb('rename') },
  { key = '<C-r>',                        cb = tree_cb('full_rename') },
  { key = 'x',                            cb = tree_cb('cut') },
  { key = 'c',                            cb = tree_cb('copy') },
  { key = 'p',                            cb = tree_cb('paste') },
  { key = 'y',                            cb = tree_cb('copy_name') },
  { key = 'Y',                            cb = tree_cb('copy_path') },
  { key = 'gy',                           cb = tree_cb('copy_absolute_path') },
  { key = '[c',                           cb = tree_cb('prev_git_item') },
  { key = ']c',                           cb = tree_cb('next_git_item') },
  { key = '-',                            cb = tree_cb('dir_up') },
  { key = 's',                            cb = tree_cb('system_open') },
  { key = 'q',                            cb = tree_cb('close') },
  { key = 'g?',                           cb = tree_cb('toggle_help') },
}


