-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
    },
    config = function()
        require('telescope').setup({
            defaults = {
                layout_strategy = 'vertical',
                file_ignore_patterns = {"%.rbi$", "%.git/"}
            }
        })
        require('telescope').load_extension('fzf')
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader><leader>', builtin.find_files,
                       {desc = 'Telescope find files'})

        vim.keymap.set('n', '<leader>fd', builtin.diagnostics,
                       {desc = 'Telescope Diagnostic Picker'})

        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files({cwd = vim.fn.stdpath("config")})
        end, {desc = 'Telescope find files in nvim config'})

        vim.keymap.set('n', '<leader>fb', builtin.buffers,
                       {desc = 'Telescope buffers'})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags,
                       {desc = 'Telescope help tags'})

        local grep = require("config.telescope.grep")
        vim.keymap.set('n', '<leader>fg', function() grep.setup() end,
                       {desc = 'Telescope find files'})

        local grep_from_cwd = require("config.telescope.grep")
        -- Picker that look from the current directory when navigating with oil
        vim.keymap.set('n', '<leader>fc', function()
            local current_buffer = vim.api.nvim_get_current_buf()
            local cwd = require('oil').get_current_dir(current_buffer)
            grep_from_cwd.setup({cwd = cwd})
        end, {desc = 'Grep from cwd'})
    end
}
