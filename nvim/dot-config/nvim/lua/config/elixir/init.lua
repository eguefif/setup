-- Elixir helpers: keymaps for Elixir buffers
local functions = require('config.elixir.functions')
local alias = require('config.elixir.alias')

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'elixir',
    callback = function(ev)
        vim.keymap.set('n', '<leader>cf', function()
            functions.create_function(false)
        end, {buffer = ev.buf, desc = 'Elixir: create public function'})
        vim.keymap.set('n', '<leader>cp', function()
            functions.create_function(true)
        end, {buffer = ev.buf, desc = 'Elixir: create private function'})
        vim.keymap.set('n', '<leader>ck', alias.add_alias,
                       {buffer = ev.buf, desc = 'Elixir: add alias'})
    end
})
