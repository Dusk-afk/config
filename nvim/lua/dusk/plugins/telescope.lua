return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                          , branch = '0.1.x',
	dependencies = {
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fd', builtin.git_files, { desc = 'Telescope git files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set(
            'n',
            '<leader>en',
            function()
                builtin.find_files {
                    cwd = vim.fn.stdpath('config')
                }
            end,
            { desc = 'Telescope find files in config dir' }
        )
	end,
}
