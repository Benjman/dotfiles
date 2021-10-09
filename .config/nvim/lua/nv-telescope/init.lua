require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_prefix = '> ',
		selection_caret = '> ',
		entry_prefix = '  ',
		initial_mode = 'insert',
		selection_strategy = 'reset',
		sorting_strategy = 'descending',
		layout_strategy = 'horizontal',
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter =  require'telescope.sorters'.get_fuzzy_file,
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		file_ignore_patterns = { 'build' },
		path_display = absolute,
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_devicons = true,
		use_less = true,
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
	}
}

local opt = {silent = true, noremap = true}
local map = vim.api.nvim_set_keymap

map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', opt)
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', opt)
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', opt)
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', opt)

