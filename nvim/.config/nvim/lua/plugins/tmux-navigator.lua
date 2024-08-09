return {
	'christoomey/vim-tmux-navigator',
	vim.keymap.set('n', '<Leader>H', ':TmuxNavigateLeft<cr>'),
	vim.keymap.set('n', '<Leader>J', ':TmuxNavigateDown<cr>'),
	vim.keymap.set('n', '<Leader>L', ':TmuxNavigateRight<cr>'),
	vim.keymap.set('n', '<Leader>K', ':TmuxNavigateUp<cr>'),
	vim.keymap.set('n', '<Leader>P', ':TmuxNavigatePrevious<cr>'),
}
